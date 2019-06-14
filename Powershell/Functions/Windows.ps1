function Append-Path
{
    param([string]$newPathEntry)

    if(!$newPathEntry) {
        Throw "newPathEntry is required!"
    }
    $currentPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path.split(';')
    [Collections.Generic.List[String]]$currentPath = $currentPath
    $currentPath.Add($newPathEntry)
	Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value ($currentPath -join ';')
}

function Set-EnvironmentVariable
{
    param([string]$name, [string]$value, [bool]$systemScope)

    $scope = [System.EnvironmentVariableTarget]::User
    if($systemScope) {
        $scope = [System.EnvironmentVariableTarget]::Machine
    }

    [System.Environment]::SetEnvironmentVariable("$NAME", "$value", $scope)
}
