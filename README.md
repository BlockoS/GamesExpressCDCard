# GamesExpressCDCard
This repository is containing an ingoing effort to disassemble and comment the the Games Express CD Card for the PC Engine.
This HuCard was mandatory to run Games Express CD games.

The disassembly was performed using [Etripator](https://github.com/BlockoS/etripator).

```
etripator -l labels.json -o out.json bank0.json games_express_cd_card.pce
```

The ROM being disassembled corresponds to the V2 (aka Bikini girl) version. Its SHA512 hash is:
```
42dc628e0ede7a569b9d7cb19f7b419796ba06baae0d146dd81d95cc0665736d0bef6d0548495f9094d8c1e40b901077c9fbfe0a1b2e00035983b584b2a3b272
```