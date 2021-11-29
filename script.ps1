$icon_path = $args[0]
$outputPath = $args[1]
$localPath = (Get-Location).Path

# Create temp dir
New-Item -ItemType Directory -Force -Path .\temp\icons_all

# Make zip from svg files in a folder
Compress-Archive $icon_path -DestinationPath .\temp\temp.zip

# Extract zip file
Expand-Archive .\temp\temp.zip -DestinationPath .\temp\temp_icons

# Collect all svg files into 1 folder
Get-ChildItem -Path ".\temp\temp_icons\*.svg" -Recurse | Move-Item -Destination ".\temp\icons_all" 

# Get a csv of svg files
$iconList = (Get-ChildItem -Path '.\temp\icons_all' ).FullName -join ","

# Run iconmoon-cli
icomoon-cli -i $iconList -s $localPath/selection-empty.json -o $outputPath -f 

# cleanup
Remove-Item .\temp -Recurse -ErrorAction Ignore