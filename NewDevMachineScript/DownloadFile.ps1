function DownloadFile($url, $fileName)
{
	$client = new-object System.Net.WebClient
	$file = (Get-Location).Path + "\$fileName"
	$client.DownloadFile("$url", $file)
	return $file
}
