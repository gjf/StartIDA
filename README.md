# StartIDA
IDA portabilizer - Starts IDA and copies/deletes settings from folders and registry.
Works with IDA 6.x (as 7.0 is a crap).
At the present time the following is copies/deletes:

.\BinDiff\INI <==> %appdata%\zynamics\
.\Hex-Rays <==> %appdata%\Hex-Rays\
HKEY_CURRENT_USER\Software\Hex-Rays

Syntax:

StartIDA [parameter], where
parameter could be:
/32, -32, x32 means starting IDA in 32 bit mode
/64, -64, x64 means starting IDA in 64 bit mode
If parameter is omitted the mode will be the same as operating system.
