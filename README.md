# Clowd.Squirrel.Release
A powershell release script for Clowd.Squirrel

The script searches for the latest installed nuget clowd.squirrel package and uses it to build the update.

Change the top varables:
```
C:\Releases\<packName>-<verison>-full.nupkg
C:\Projects\<project>\bin\<buildType>\<FileName>
$packName = "PackName"
$project = "Project"
$buildType = "Publish"
$releaseDir = "c:\Releases\"
$FileName = "FileVersionGet.exe"
```
