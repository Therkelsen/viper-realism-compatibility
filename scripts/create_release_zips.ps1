param (
    [string]$mod_version,
    [string]$spt_version
)

# Define the release directory
$releaseDir = ".\release"

# Create release directory if it doesn't exist
if (-Not (Test-Path -Path $releaseDir)) {
    New-Item -ItemType Directory -Path $releaseDir -Force
}

# Create directory names within the release directory
$baseDir = "$releaseDir\viper-realism-compatibility_${mod_version}_SPT-v${spt_version}"

# Define the inner directory structure
$innerDir = "user\mods\SPT-Realism\db\put_new_stuff_here\Viper"

# Create the directories
New-Item -ItemType Directory -Path "$baseDir\$innerDir" -Force

# Define the list of files to move
$filesToMove = @(
    'Viper\TTI_Pit_Viper.json',
    'Viper\Viper_Helmet_MK3.json',
    'Viper\Joey_Jordison_Mask.json'
)

# Move files to both directories
foreach ($file in $filesToMove) {
    Copy-Item -Path $file -Destination "$baseDir\$innerDir"
}

# Create zip files
Compress-Archive -Path "$baseDir\*" -DestinationPath "$releaseDir\viper-realism-compatibility_${mod_version}_SPT-v${spt_version}.zip" -Force

# Clean up the created directories
Remove-Item -Recurse -Force "$baseDir"