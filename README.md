# Clowd.Squirrel.Release
A powershell release script for Clowd.Squirrel

The script searches for the latest installed nuget clowd.squirrel package and uses it to build the update.

## Edit varables of PublishBuild.ps1
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

## To publish the build on deploy
Content of *.csproj file:
```
<Target Name="CustomActionsAfterPublish" AfterTargets="Publish">
	<PropertyGroup>
		<PowerShellExe Condition=" '$(PowerShellExe)'=='' ">%WINDIR%\System32\WindowsPowerShell\v1.0\powershell.exe</PowerShellExe>
		<ScriptLocation Condition=" '$(ScriptLocation)'=='' ">$(SolutionDir)PublishBuild.ps1</ScriptLocation>
	</PropertyGroup>
	<Message Text="The name of the publish profile is $(DestinationAppRoot)" />
	<Message Text="The run dir is $(ScriptLocation)" Importance="high" />
	<Exec Command="$(PowerShellExe) -command &quot;&amp; invoke-command -scriptblock { &amp;'$(ScriptLocation)' }&quot;" />
	<Message Text="Done running publish script" Importance="high" />
</Target>
```

## If it doesn't run the powershell script
- Sign the powershell script with a valid script to allow it to run
- Allow all scripts to be run, this can be dangerous!
