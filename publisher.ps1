$url = "https://gabriels-fantabulous-site-23ac8b.webflow.io/"
$localFolder = "C:\Safelite\webflow\website01"
$sourceFolder = "C:\Safelite\webflow\website01\gabriels-fantabulous-site-23ac8b.webflow.io" 
$amazonWebsite = "https://s3.amazonaws.com/memberbase.com/index.html"

$bucketName = "memberbase.com"
$region = "us-east-1"
$profile = "safelite_username"

Clear-Host
$null = Read-Host "Press ENTER to Start the Transfer from Webflow"

# Create the local folder if it doesn't exist
New-Item -ItemType Directory -Force -Path $localFolder

# Use wget to download all website files to the local folder
#& wget.exe --recursive --no-parent --page-requisites --adjust-extension --convert-links --mirror --domains=svg,jpg,png,gif -P $localFolder $url 
#& wget.exe --recursive --no-parent --page-requisites --adjust-extension --convert-links --domains gabriels-fantabulous-site-23ac8b.webflow.io --include-directories /images --no-clobber --no-parent -P $localFolder $url
#& wget.exe --recursive --no-parent --page-requisites --adjust-extension --convert-links --no-clobber --accept svg,jpg,png,gif -P $localFolder $url
& wget.exe --mirror --include-directories "/images/**" --no-clobber -P $localFolder $url



Start-Sleep -Seconds 3

Clear-Host
$null = Read-Host "Press ENTER to Start the Transfer to Safelite AWS Services"

# Sync the extracted files to S3 bucket
aws s3 sync $sourceFolder s3://$bucketName --region $region --profile $profile 

# Display the final message
Clear-Host
Write-Host "Transfer Success! Webflow website has been successfully transfered to AWS Server."
$null = Read-Host "Press ENTER to Continue"
Clear-Host
Start-Process $amazonWebsite 
