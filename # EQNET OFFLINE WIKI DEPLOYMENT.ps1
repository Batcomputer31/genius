# EQNET OFFLINE WIKI DEPLOYMENT
# File: EQWikiOffline.ps1
# Author: RA:CREATOR
# Function: Downloads, installs, and opens offline Wikipedia system
# Requires: Kiwix CLI + ZIM File

# === CONFIG ===
$KiwixURL = "https://download.kiwix.org/release/kiwix-tools/kiwix-tools_win-i686.zip"
$ZimURL = "https://download.kiwix.org/zim/wikipedia_en_simple_all_maxi.zim"
$InstallPath = "C:\EQSYSTEM\WIKIOFFLINE"
$ZimFile = "$InstallPath\wikipedia_en_simple_all_maxi.zim"
$KiwixBin = "$InstallPath\kiwix\

Sent from Proton Mail Android