$AnaDizin=Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

$Tarih = Get-Date -format "dd_MM_yyyy"

# Fortigate için Ftp olarak alınan Conf uzantılı dosyaların bulunduğu klasör tarafır ve *.conf dosyaları ayıklanır
Get-ChildItem -Path "D:\FTP\CONFIG_BACKUP" -Recurse -Include *.conf -Force | Select-Object FullName,DirectoryName,BaseName | ForEach-Object {

$Config_Archine_Name=$_.BaseName + "_" + $Tarih
$Config_Full_Name=$_.FullName
$Config_Directory_Name=$_.DirectoryName + "\ARCHIVE\$Config_Archine_Name.zip"

# Arcihe Klasörü Sorgulanır daha önce bu dosya ile ilgili alınmış bir dosya varsa arsivleme işlemi yapılmaz
if ( (Test-Path -Path $Config_Directory_Name) -eq $False) {

$Process = new-Object System.Diagnostics.Process
$Process.StartInfo.WindowStyle="Hidden"
$Process.StartInfo.FileName="$AnaDizin\APPLICATION\7z\7za.exe"
$Process.StartInfo.Arguments="a -tzip $Config_Directory_Name $Config_Full_Name"
[void]$Process.Start()

sleep -Seconds 1

}


# Alınmış bir Arhive dosyası varsa ilgili conf dosyası silinir.
if ( (Test-Path -Path $Config_Directory_Name) -eq $True -and (Test-Path -Path $Config_Full_Name) -eq $True ) {

Remove-Item -Path $Config_Full_Name -Force

}


}