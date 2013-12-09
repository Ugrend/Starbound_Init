Starbound_Init
==============

Starbound Init Script for Redhat/Centos

Init Script made for CentOS, includes updating of server

Requires:
--------------
  SteamCMD https://developer.valvesoftware.com/wiki/SteamCMD
  Steam Account with Starbound
  
Optional:
--------------
  Starbound files (SteamCMD will download starbound if not found)

To get Starbound working on Centos:  
Packages:
--------------  
  yum install libfreetype.so.6
  
  yum install libpng12.so.0
  
  copy libstdc++.so.6 from SteamCMD/linux32/ to your linux32 dir in starbound
  
  (other steps maybe required this is what I had to do to get running)
  
Setup:
--------------
Create User starbound
    useradd starbound

    
Place starbound in /etc/init.d chmod 700 make sure is owned by root (this is because it contains your steam password)

Modify the script and enter steam credentals

Modify STEAMCMDPATH and STARBOUNDPATH to match your config

chkconfig starbound on (for automatic startup)

/etc/init.d/starbound start to start starbound

Make sure Starbound path is accessable/owned by starbound (same with steamcmd)

????

Profit



  
  
