#\Releases\<packName>-<verison>-full.nupkg
$packName = "<packName>"
$project = "<project>"
$buildType = "<Publish>"
$releaseDir = "c:\Releases\"

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Write-host "My start directory is $dir"
Set-Location $dir

# Get full Path of exe
$exePath = resolve-path ".\$($project)\bin\$($buildType)\<file name>.exe"
# Get Exe version
$verison = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($exePath).FileVersion

# build / publish your app
#dotnet publish -c Release -o ".\publish" 

# find the latest Squirrel.exe path and add an alias
$core = ls -Filter * ($env:USERPROFILE + "\.nuget\packages\clowd.squirrel\") | sort { [version]($_.Name -replace '^(\d+(\.\d+){1,3}).*$', '$1') } -Descending | select -Index 0
Set-Alias Squirrel ($core.FullName + "\tools\Squirrel.exe");

echo "Using Squirrel version: $core.Name"

echo "Version of Update: $verison" 

# Convert to full path
$path = resolve-path ".\Releases"
# Get the current release file path
$path = "$($path)\$($packName)-$($verison)-full.nupkg"
echo "$($path)"
# check if the release is there already
if([System.IO.File]::Exists($path)) {
    Write-Host "Release found with same version: $path"
    Exit
}

Squirrel pack `
    --framework net6 `
    --packName "$($packName)" `
    --packVersion "$($verison)" `
    --packAuthors "<Replace with your name>" `
    --packDirectory ".\$($project)\bin\$($buildType)" `
    --icon ".\Icons\ico\ico.ico" `
    --splashImage ".\splash.gif"
     #   --msi "x64" `
echo "Copy files to server"
Copy-Item -Path ".\Releases\*" -Destination "$($releaseDir)" -Recurse -PassThru -Exclude "*.nupkg"
Copy-Item -Path ".\Releases\*" -Destination "$($releaseDir)" -Recurse -PassThru -Include "*$($packName)-$($verison)-*.nupkg"
echo "Done"

echo "Manual Update with if needed to repair install: $> .\Update.exe --update=""$($$($releaseDir))"""
