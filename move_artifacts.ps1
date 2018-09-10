<#
	https://jacanovsts.visualstudio.com/ManagedXZLZMA/_build/latest?definitionId=2
	https://jacanovsts.visualstudio.com/ManagedXZLZMA/_build?buildId=42
#>

function DownloadAndExpandArtifact([string]$buildId, [string]$artifactName)
{
	$artifactUrl = 'https://jacanovsts.visualstudio.com/ManagedXZLZMA/_apis/build/builds/' + $buildId + '/artifacts?artifactName=' + $artifactName + '&api-version=5.0-preview.3&%24format=zip'
	wget $artifactUrl -OutFile "artifacts/$artifactName.zip"
	
	Expand-Archive "artifacts/$artifactName.zip" -DestinationPath "artifacts/"
}

if (Test-Path "artifacts") { Remove-Item "artifacts" -Force -Recurse }
New-Item "artifacts" -type directory -force

DownloadAndExpandArtifact "42" "android"
DownloadAndExpandArtifact "42" "ios"
DownloadAndExpandArtifact "42" "windows"
DownloadAndExpandArtifact "42" "uwp"

Copy-Item artifacts/windows/* src/ManagedXZLZMA/ManagedXZLZMA.Native/build/net45 -Force -Recurse
Copy-Item artifacts/uwp/* src/ManagedXZLZMA/ManagedXZLZMA.Native/build/uap10.0 -Force -Recurse
Copy-Item artifacts/android/* src/ManagedXZLZMA/ManagedXZLZMA.Native/build/MonoAndroid -Force -Recurse
Copy-Item artifacts/ios/* src/ManagedXZLZMA/ManagedXZLZMA.Native/build/XamariniOS -Force -Recurse