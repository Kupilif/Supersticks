@echo off
SETLOCAL

CALL config.bat

IF NOT EXIST .\bin\ MD bin
%_fasm% .\Supersticks.asm .\bin\Sticks.com
IF NOT %ERRORLEVEL% EQU 0 GOTO end

IF NOT -%1-==-release- GOTO end
%_7zip% a -tzip -ssw -mx5 .\bin\Sticks.zip .\bin\Sticks.com

:end
