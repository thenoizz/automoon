$icon_url = $args[0]
$localPath = (Get-Location).Path
$env:CHROME_PATH = (Get-Process -Name "Google Chrome")[0].Path

Remove-Item .\temp -Recurse -ErrorAction Ignore
Remove-Item .\outfiles -Recurse -ErrorAction Ignore

New-Item -ItemType Directory -Force -Path .\temp\icons_all
New-Item -ItemType Directory -Force -Path .\outfiles

Invoke-WebRequest -Uri $icon_url -OutFile ".\temp\onyx_icons.zip"

Expand-Archive .\temp\onyx_icons.zip -DestinationPath .\temp\onyx_icons

Get-ChildItem -Path ".\temp\onyx_icons\icons\*.svg" -Recurse | Move-Item -Destination ".\temp\icons_all" 

$iconList = (Get-ChildItem -Path '.\temp\icons_all' ).FullName -join ","

icomoon-cli -i $iconList -s $localPath/selection-empty.json -o $localPath/outfiles/

