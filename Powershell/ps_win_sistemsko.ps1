#preverimo diskovne razdelke (allocation block size itd..)
Get-CimInstance -classname win32_volume | Select-Object name, label, capacity, blocksize

#preverimo če je volume DAX formated
Get-Volume -DriveLetter F | Get-Partition | ft DriveLetter,IsDAX