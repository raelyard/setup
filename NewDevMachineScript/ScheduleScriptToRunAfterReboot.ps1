function ScheduleScriptToRunAfterReboot
{
	param ($script)
	
	C:\Windows\system32\schtasks.exe /create /sc ONSTART /rl HIGHEST /np /z /v1 /ru SYSTEM /tr "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Unrestricted -command '$script'" /tn "Resume After Reboot"
}
