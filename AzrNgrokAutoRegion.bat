echo Author: irineu
@echo off
title Azure-Auto-Region

echo Download all files...
curl --silent -O https://cdn.glitch.com/6be4f91b-3ac8-4909-b8a3-ad89f361e723%2Fngrok.exe?v=1617130058932
curl --silent -O https://raw.githubusercontent.com/DevMoonTv/Monvps/master/Files/NGROK-US.bat?token=ASCQAVEHYUY6AGSWMJNZCYDAMNYRY


echo Copy NGROK to System32...
copy ngrok.exe C:\Windows\System32 >nul

echo CONNECT NGROK AUTH TOKEN...
start NGROK.bat >nul


echo Check Region for NGROK...
curl -s ifconfig.me >ip.txt
set /p IP=<ip.txt
curl -s ipinfo.io/%IP%?token=52e07b22f25013 >full.txt
type full.txt | jq -r .country >region.txt
type full.txt | jq -r .city >location.txt
set /p LO=<location.txt
set /p RE=<region.txt
if %RE%==BR (start ngrok tcp 3389)
if %RE%==BR (start ngrok tcp 3389)

if %RE%==BR (start ngrok tcp --region sa 3389)


echo Finished!
NGROK-CHECK.bat
