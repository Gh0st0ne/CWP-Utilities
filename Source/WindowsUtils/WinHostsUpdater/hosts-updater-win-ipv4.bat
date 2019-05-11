title CWP Utilities >nul 2>nul
mode con: cols=99 lines=33 >nul 2>nul
cd %~dp0
@echo off
del "hosts.bak" >nul 2>nul
del "final-hosts.txt" >nul 2>nul
rename HOSTS hosts.bak >nul 2>nul
cd bin
rm hosts.* >nul 2>nul
rm final-hosts.txt >nul 2>nul
@echo on
wget -nv -O hosts.1 "http://winhelp2002.mvps.org/hosts.txt"
wget -nv -O hosts.2 "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
wget -nv -O hosts.3 "https://www.malwaredomainlist.com/hostslist/hosts.txt"
wget -nv -O hosts.4 "https://hosts-file.net/ad_servers.txt"
wget -nv -O hosts.5 "https://hosts-file.net/exp.txt"
wget -nv -O hosts.6 "https://adaway.org/hosts.txt"
wget -nv -O hosts.7 "https://raw.githubusercontent.com/bongochong/CombinedPrivacyBlockLists/master/WindowsTelemetryBlockSupplements/SBBTYZ-IPv4.txt"
wget -nv -O hosts.8 "https://raw.githubusercontent.com/bongochong/CombinedPrivacyBlockLists/master/NoFormatting/Device9domains-IPv4.txt"
cd jre\bin
java -cp "..\..\MergeHosts.jar" com.ri.hosts.MergeHosts "..\.."
cd ..
cd ..
sed -i "/localhost/d" hosts.final
sed -i "s/^127.0.0.1/0.0.0.0/g" hosts.final
sort hosts.final > sorted-hosts.txt
mv sorted-hosts.txt final-hosts.txt
cp final-hosts.txt ..
cd ..
@echo off
cscript optimizer.js
timeout 5 >nul 2>nul
@echo on
copy /Y HOSTS %SystemDrive%\Windows\System32\Drivers\etc\HOSTS
ipconfig /flushdns
@echo off
echo ...
echo Done! Your hosts file has been updated. There is nothing left for you to do here.
timeout 1 >nul 2>nul
echo ...
echo Hit enter to return to the main menu.
echo ...
pause
cd ..
WinUtilsMultiLauncher.bat
