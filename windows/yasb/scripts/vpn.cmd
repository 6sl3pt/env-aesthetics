@echo off
powershell.exe ^
  -NoProfile ^
  -ExecutionPolicy Bypass ^
  -Command "& '%USERPROFILE%\.config\yasb\scripts\vpn.ps1'"
