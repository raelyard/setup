function Edit-Profile{np $profile}
function locateCommand{ get-command $args | format-list * }
function hosts{ & "C:\Program Files (x86)\Notepad++\notepad++.exe" $env:windir\system32\drivers\etc\hosts }
function machineConfig{ & "C:\Program Files (x86)\Notepad++\notepad++.exe" $env:windir\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config }
function clipX
{
	if((get-process clipx -ErrorAction SilentlyContinue) -eq $null)
	{
		if(test-path "C:\Program Files (x86)\ClipX\clipx.exe")
		{
			& "C:\Program Files (x86)\ClipX\clipx.exe"
		}
	}
}
