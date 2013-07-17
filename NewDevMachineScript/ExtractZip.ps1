function ExtractZip([string] $filename = $Null, [string] $destinationSubdirectory = "extract")
{
	if(!$filename)
	{
		echo "no file to unzip"
	}
	else
	{
		$shell_app=new-object -com shell.application
		$zip_file = $shell_app.namespace((Get-Location).Path + "\$filename")
		new-item -force ((Get-Location).Path + "\$destinationSubdirectory") -itemType directory
		$destination = $shell_app.namespace((Get-Location).Path + "\$destinationSubdirectory")
		$destination.CopyHere($zip_file.items(), 0x14)
	}
}
