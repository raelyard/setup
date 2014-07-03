function Edit-Profile{np $profile}
function locateCommand{ get-command $args | format-list * }
function hosts{ & "C:\Program Files (x86)\Notepad++\notepad++.exe" $env:windir\system32\drivers\etc\hosts }
