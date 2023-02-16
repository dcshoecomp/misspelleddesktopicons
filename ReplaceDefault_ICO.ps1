$ext = ".ps1"
$ico = "pwsh.ico"
$bkupPath = "C:\ico\Default Regkeys" 
$icoPath = "C:\ico"

#get the extentions ID
$progid = (get-item -path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\$ext\UserChoice").getvalue("ProgID")

#build path for registry
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR

#backup the current registry item
reg export HKEY_CLASSES_ROOT\$progid\DefaultIcon "$bkupPath\$progid.reg"

if((read-host -prompt "Are you ready to replace $progid?") -eq "y"){

	#Replace the icon
	Set-ItemProperty -Path HKCR:\\$progid\DefaultIcon -Name ‘(Default)’ -Value "$icoPath\$ico"
}
