/* dump.c -- Dump files from REDUMP games express disk images.
 * 
 * Copyright (C) 2022 MooZ
 *
 * This software may be modified and distributed under the terms
 * of the MIT license.  See the LICENSE file for details.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

// volume descriptor types.
enum VDType {
    VD_BootRecord = 0,
    VD_Primary = 1,
    VD_Supplementary = 2,
    VD_Partition = 3,
    VD_Terminator = 0xff
};

static const size_t g_mdf_header_sz = 16;
static const size_t g_sector_phys_sz = 2352;
static const size_t g_sector_logi_sz = 2048;
static uint16_t g_lb_size = g_sector_logi_sz;
FILE *g_in;

uint16_t u16lsb(const uint8_t *ptr) {
    return ptr[0] | (ptr[1]<<8);
}

uint16_t u16msb(const uint8_t *ptr) {
    return ptr[1] | (ptr[0]<<8);
}

uint32_t u32lsb(const uint8_t *ptr) {
    return ptr[0] | (ptr[1]<<8) | (ptr[2]<<16) | (ptr[3]<<24);
}

uint32_t u32msb(const uint8_t *ptr) {
    return ptr[3] | (ptr[2]<<8) | (ptr[1]<<16) | (ptr[0]<<24);
}

size_t compute_seek(size_t offset) {
    size_t sectors = offset / g_sector_logi_sz;
    size_t delta = offset % g_sector_logi_sz;
    return g_mdf_header_sz + (sectors * g_sector_phys_sz) + delta;
}

int seek(size_t sz) {
    size_t offset = compute_seek(sz);
    if(fseek(g_in, offset, SEEK_SET) == -1) {
        fprintf(stderr, "seek failed: %s\n", strerror(errno));
        return 0;
    }
    return 1;
}

int read(void *out, size_t sz) {
    // compute current sector address and offset
    size_t phys_offset = ftell(g_in) - g_mdf_header_sz;
    size_t delta = phys_offset % g_sector_phys_sz;
    size_t remaining = g_sector_logi_sz - delta;

    if(sz < remaining) {
        // we don't cross sector boundary
        if(fread(out, 1, sz, g_in) != sz) {
            fprintf(stderr, "read failed: %s\n", strerror(errno));
            return 0;
        }
    } else {
        // the read spans multiple sectors
        size_t n = remaining;
        size_t offset = delta;

        for(remaining = sz; remaining > 0; ) {
            if(fread(out, 1, n, g_in) != n) {
                fprintf(stderr, "read failed: %s\n", strerror(errno));
                return 0;
            }
            out += n;
            offset += n;
            if(offset >= g_sector_logi_sz) {
                offset = g_sector_phys_sz - g_sector_logi_sz;
                if(fseek(g_in, offset, SEEK_CUR) == -1) {
                    fprintf(stderr, "seek failed: %s\n", strerror(errno));
                    return 0;
                }
                offset = 0;
            }

            remaining -= n;
            if(remaining >= g_sector_logi_sz) {
                n = g_sector_logi_sz;
            } else {
                n = remaining;
            }
        }
    }
    return 1;
}

int dump_files(const uint8_t *ptr) {
    uint32_t lba = u32lsb(ptr+2);
    uint32_t len = u32lsb(ptr+10);

    size_t offset = lba * g_lb_size;
    if(!seek(offset)) {
        fprintf(stderr, "failed to seek to directory entries.\n");
        return 0;
    }

    uint8_t data[2048];
    uint8_t entry[256];
    while(1) {
        if(!read(&entry[0], 1)) {
            fprintf(stderr, "failed to read directory entry size.\n");
            return 0;
        }
        if(entry[0] == 0) {
            break;
        }
        if(!read(&entry[1], entry[0]-1)) {
            fprintf(stderr, "failed to read directory entry.\n");
            return 0;
        }
        if(entry[25] == 0) {
            len = entry[32];
            if(len) {
                len -= 2;
            }
            entry[33+len] = '\0';

            lba = u32lsb(&entry[2]);
            len = u32lsb(&entry[10]);
            offset = lba * g_lb_size;

            fprintf(stdout, "dumping %s (off: %u, len: %u)\n", &entry[33], lba, len);

            long int backup = ftell(g_in);

            if(!seek(offset)) {
                fprintf(stderr, "failed to seek to %s data.\n", &entry[33]);
                return 0;
            }

            FILE *out = fopen((const char*)&entry[33], "wb");
            for(uint32_t j=0, k=g_sector_logi_sz; j<len; j+=k) {
                if(k > len) {
                    k = len;
                }
                if(!read(data, k)) {
                    fprintf(stderr, "failed to read %s data.\n", &entry[33]);
                    fclose(out);
                    return 0;
                }

                if(fwrite(data, 1, k, out) != k) {
                    fprintf(stderr, "failed to dump %s: %s\n", &entry[33], strerror(errno));
                    fclose(out);
                    return 0;
                }                
            }
            fclose(out);

            fseek(g_in, backup, SEEK_SET);
        }
    }
    return 1;
}

int main(int argc, char **argv) {
    int ret =  EXIT_FAILURE;
    if(argc != 2) {
        fprintf(stderr, "missing input file.\n");
    } else {
        g_in = fopen(argv[1], "rb");
        if(g_in == NULL) {
            fprintf(stderr, "failed to open %s: %s\n", argv[1], strerror(errno));
        } if(fseek(g_in, g_mdf_header_sz, SEEK_SET) == -1) {    // skip mdf header
            fprintf(stderr, "failed to skip mdf header: %s\n", strerror(errno));
        } else if(seek(32768) == 0) {   // System area: 32KB (unused) 
            fprintf(stderr, "failed to skip system area\n");
        } else {
            uint8_t buffer[2048];

            do {
                if(read(buffer, 2048) == 0) {
                    fprintf(stderr, "failed to read volume descriptor\n");
                    break;
                }
                if(buffer[0] == VD_Primary) {
                    g_lb_size = u16lsb(&buffer[128]);

                    printf("\nsystem identifier \""); fwrite(&buffer[8], 1, 32, stdout);
                    printf("\"\nvolume identifier \""); fwrite(&buffer[40], 1, 32, stdout);
                    printf("\"\nvolume set identifier \""); fwrite(&buffer[190], 1, 128, stdout);
                    printf("\"\npublisher set identifier \""); fwrite(&buffer[318], 1, 128, stdout);
                    printf("\"\ndata preparer identifier \""); fwrite(&buffer[446], 1, 128, stdout);
                    printf("\"\napplication identifier \""); fwrite(&buffer[574], 1, 128, stdout);
                    printf("\"\n");

                    dump_files(&buffer[156]);
                    break;
               }
            
            } while(buffer[0] != VD_Terminator);
        }
    }
    return ret;
}