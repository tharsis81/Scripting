#preverimo diskovne razdelke
Get-CimInstance -classname win32_volume | Select-Object name, label, capacity, blocksize