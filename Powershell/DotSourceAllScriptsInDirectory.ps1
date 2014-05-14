function DotSourceAllScriptsInDirectory
{
	param($directory)

	if(test-path $directory)
	{
		$scripts = get-childitem -recurse "$directory" -filter "*.ps1"
		foreach($script in $scripts)
		{
			echo $script.fullname
			. $script.fullname
		}
	}
}

function ExecuteAllScriptsInDirectory
{
	param($directory)

	if(test-path $directory)
	{
		$scripts = get-childitem -recurse "$directory" -filter "*.ps1"
		foreach($script in $scripts)
		{
			echo $script.fullname
			$script.fullname
		}
	}
}

function ImportAllAliasesInDirectory
{
	param($directory)

	if(test-path $directory)
	{
		$aliases = get-childitem -recurse "$directory" -filter "*.aliases"
		foreach($alias in $aliases)
		{
			echo $alias.fullname
			import-alias $alias.fullname
		}
	}
}
