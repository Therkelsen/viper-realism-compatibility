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
    'Viper\AK.json',
    'Viper\AR-15.json',
    'Viper\AWM.json',
    'Viper\CoCoLemon_Ammo.json',
    'Viper\CoCoLemon_Attachments.json',
    'Viper\CoCoLemon_Gear.json',
    'Viper\CoCoLemon_Weapons.json',
    'Viper\HK416.json',
    'Viper\Joey_Jordison_Mask.json',
    'Viper\MMFAC_Ammo.json',
    'Viper\MMFAC_Attachments.json',
    'Viper\MP5K.json',
    'Viper\SVD.json',
    'Viper\TTI_Pit_Viper.json'
)

# Move files to both directories
foreach ($file in $filesToMove) {
    Copy-Item -Path $file -Destination "$baseDir\$innerDir"
}

# Create zip files
Compress-Archive -Path "$baseDir\*" -DestinationPath "$releaseDir\viper-realism-compatibility_${mod_version}_SPT-v${spt_version}.zip" -Force

# Clean up the created directories
Remove-Item -Recurse -Force "$baseDir"