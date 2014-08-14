function CreateIisApplication
{
	param($siteName, $applicationName, $applicationPhysicalPath, $hostName, $createSiteIfNotFound = $False, $sitePhysicalPathToUseIfCreating = $Null, $forceSiteRecreation = $false, $port = 80, $applicationPoolName = "ASP.NET v4.0")

	if(!$siteName)
	{
		throw "Please provide a site name"
	}
	if(!$applicationPhysicalPath)
	{
		throw "Please provide an application physical path"
	}
	if(($createSiteIfNotFound -or $forceSiteRecreation) -and !$sitePhysicalPathToUseIfCreating)
	{
		throw "You have to give a site physical path if you want to create a site"
	}
	
	[System.Reflection.Assembly]::LoadFrom( "C:\windows\system32\inetsrv\Microsoft.Web.Administration.dll" )
	$manager = New-Object Microsoft.Web.Administration.ServerManager

	$site = $manager.Sites[$siteName]
	if($site -and $forceSiteRecreation)
	{
		$site.Delete()
		$manager.Sites.Remove($site)
		$site = $Null
		$createSiteIfNotFound = $True
	}
	if(!$site)
	{
		if($createSiteIfNotFound)
		{
			$site = $manager.Sites.Add($siteName, $sitePhysicalPathToUseIfCreating, $port)
			$site.Applications["/"].ApplicationPoolName = ".NET v4.5"
			if($hostName)
			{
				$site.Bindings.Add(":80:$hostName", "http")
				AddLocalHostsFileEntry($hostName)
			}
		}
		else
		{
			throw "Site not found"
		}
	}

	$application = $site.Applications["/$applicationName"]
	if($application)
	{
		$application.Delete()
		$site.Applications.Remove($application)
	}
	$site.Applications.Add("/$applicationName", "$applicationPhysicalPath")
	$site.Applications["/$applicationName"].ApplicationPoolName = $applicationPoolName

	$manager.CommitChanges()
}

function AddLocalHostsFileEntry
{
	param($hostName)
	$hostsFilePath = "$env:windir\system32\drivers\etc\hosts"
	if(!(Get-Content -Path $hostsFilePath | Select-String "$hostName" -quiet))
	{
		$hostsFileContent = Get-Content -Path $hostsFilePath
		$hostsFileContent += "127.0.0.1`t$hostName"
		Set-Content -Value $hostsFileContent -Path $hostsFilePath -Force -Encoding ASCII
	}
}
