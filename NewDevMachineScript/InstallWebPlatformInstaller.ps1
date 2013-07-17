function InstallWebPlatformInstaller
{
	$client = new-object System.Net.WebClient
	$file = (Get-Location).Path + "\WebPlatformInstallerCommandLineInterface.zip"
	$client.DownloadFile("http://go.microsoft.com/fwlink/?LinkId=233753", $file)

	.\ExtractZip.ps1 WebPlatformInstallerCommandLineInterface.zip WebPlatformInstaller
	remove-item WebPlatformInstallerCommandLineInterface.zip
}
