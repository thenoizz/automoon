$icon_url = $args[0]
$outputPath = $args[1]
$localPath = (Get-Location).Path

# optional, on MacOS icomoon-cli failed to launch Chrome
$env:CHROME_PATH = (Get-Process -Name "Google Chrome")[0].Path

# Create temp dir
New-Item -ItemType Directory -Force -Path .\temp\icons_all

# Download zip
Invoke-WebRequest -Uri $icon_url -OutFile ".\temp\temp.zip"

# Extract zip file
Expand-Archive .\temp\temp.zip -DestinationPath .\temp\temp_icons

# Collect all svg files into 1 folder
Get-ChildItem -Path ".\temp\temp_icons\icons\*.svg" -Recurse | Move-Item -Destination ".\temp\icons_all" 

# Get a csv of svg files
$iconList = (Get-ChildItem -Path '.\temp\icons_all' ).FullName -join ","

# Run iconmoon-cli
icomoon-cli -i $iconList -s $localPath/selection-empty.json -o $outputPath

# cleanup
Remove-Item .\temp -Recurse -ErrorAction Ignore