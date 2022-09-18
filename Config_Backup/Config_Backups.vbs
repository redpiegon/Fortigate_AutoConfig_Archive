Dim objShell

Set objShell = CreateObject("Wscript.Shell")

objShell.Run "c:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -nologo -Noninteractive -file C:\Config_Backup\Config_Backups.ps1" ,0,false