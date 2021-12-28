#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

// The PC Engine palette is taken from https://github.com/pceDev16/TG16_Palette .

size_t get_length(FILE *in) {
    fseek(in, 0, SEEK_END);
    size_t len = ftell(in);
    fseek(in, 0, SEEK_SET);
    len -= ftell(in);
    return len;
}

int main() {
    FILE *in, *out;

    size_t len;
    
    in = fopen("palette.pal", "rb");
    len = get_length(in);

    uint8_t *pce_palette = (uint8_t*)malloc(len);
    fread(pce_palette, 1, len, in);

    fclose(in);

    in = fopen("gx_pal_00.bin", "rb");
    if(in == NULL) {
        fprintf(stderr, "failed to open input file: %s\n", strerror(errno));
        return EXIT_FAILURE;
    }

    len = get_length(in);
    uint8_t *palette = (uint8_t*)malloc(len);
    fread(palette, 1, len, in);

    fclose(in);

    out = fopen("gx_pal_rgb.pal", "wb");
    for(int i=0; i<len; i+=2) {
        uint16_t index = palette[i] | (palette[i+1] << 8);
        fwrite(&pce_palette[3*index], 1, 3, out);
    }
    fclose(out);

    free(palette);
    free(pce_palette);

    in = fopen("gx_dat_00.bin", "rb");

    len = get_length(in);
    uint8_t *buffer = (uint8_t*)malloc(len);
    fread(buffer, 1, len, in);

    fclose(in);

    uint8_t *data = buffer;

    out = fopen("gx_dat.bin", "wb");

    uint8_t reg_a;

    uint8_t count = *data;
    data++;

    while(1) {
        reg_a = *data;

        if(reg_a == 0xff) {
            data++;
            break;
        } else if((reg_a & 0x80) == 0) {
            if((reg_a & 0x40) == 0) {
                reg_a &= 0x3f;
                fwrite(&data[1], 1, reg_a, out);
                data += reg_a + 1;
            } else {
                reg_a &= 0x3f;
                uint16_t value = data[1] | (data[2] << 8);
                for(int i=0; i<reg_a; i++) {
                    fwrite(&value, 1, 2, out);
                    value++;
                }
                data += 3;
            }
        } else if((reg_a & 0x40) == 0) {
            reg_a &= 0x3f;
            for(int i=0; i<reg_a; i++) {
                fwrite(&data[1], 1, 1, out);
            }    
            data += 2;        
        } else {
            reg_a &= 0x3f;
            for(int i=0; i<reg_a; i++) {
                fwrite(&data[1], 1, 2, out);
            }
            data += 3;
        }
    }

    fclose(out);

    free(buffer);

    return EXIT_SUCCESS;
}