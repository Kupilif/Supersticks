# Supersticks
## Overview
Game application in x86 assembly language.
## Rules
Players take from 1 to 3 sticks from board in turn. Player who took last stick loses.
## Build
Use flat assembler (FASM) compiler to build application. Steps to build via `build.bat` script:
- Set `7-Zip` archiver path to `_7zip` variable in `config.bat.template`
- Set `FASM` compiler path to `_fasm` variable in `config.bat.template`
- Rename `config.bat.template` to `config.bat`
- Run `build.bat` script 
    - `build.bat` command compiles application
    - `build.bat release` command compiles application and puts binary into zip archive
## Run
Use any MS-DOS emulator to run application. Steps to run via `start.bat` script:
- Run `npm install --global http-server` to globally install `http-server` package from npm
- Run `build.bat release` to build application
- Run `start.bat` to start HTTP server
- Navigate to `http://127.0.0.1:8080`

![Supersticks demo](https://raw.githubusercontent.com/Kupilif/Supersticks/master/Supersticks.GIF)