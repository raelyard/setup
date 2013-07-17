param($keePassPath = "C:\Program Files (x86)\KeePass Password Safe 2")

. .\DownloadFile.ps1
$file = DownloadFile "https://raw.github.com/pfn/keepasshttp/master/KeePassHttp.plgx" "KeePassHttp.plgx"

cp $file "$keePassPath"
