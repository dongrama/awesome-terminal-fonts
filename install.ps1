# Add-Type -AssemblyName System.Drawing
# $path = "C:\Users\dongr\Documents\GitHub\awesome-terminal-fonts\fonts\*.ttf"
# $path = "C:\Windows\fonts\*.ttf"

# $ttfFiles = Get-ChildItem $path

# $fontCollection = new-object System.Drawing.Text.PrivateFontCollection

# $ttfFiles | ForEach-Object {
#     $fontCollection.AddFontFile($_.fullname)
#     $fontCollection.Families[-1].Name
# }

# Add-Type -AssemblyName System.Drawing
# $FontCollection = [System.Drawing.Text.PrivateFontCollection]::new()    
# $Folder = 'C:\Users\dongr\Documents\GitHub\awesome-terminal-fonts\fonts'

# Get-ChildItem -Path $Folder -Include *.ttf, *.otf -Recurse -File |
#     Copy-Item -Destination 'C:\Windows\Fonts' -Force -Confirm:$false -PassThru |
#     ForEach-Object {
#         $FontCollection.AddFontFile($_.fullname)

#         $RegistryValue = @{
#             Path = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'
#             Name = $FontCollection.Families[-1].Name
#             Value = $_.Fullname
#         }
#     }

$LocalPath = ".\build"
 
$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
 
$Fontdir = Get-ChildItem $LocalPath | Where-Object { $_.Extension -EQ ".ttf" }

Write-Output "Installing awesome-terminal-fonts"
foreach ($File in $Fontdir) {
    [Console]::Write("Installing $File...")
    $targFonts1 = "C:\Windows\Fonts\$File"
    $targFonts2 = "C:\Users\dongr\AppData\Local\Microsoft\Windows\Fonts\$File"

    If ((-not(Test-Path $targFonts1) -and (-not(Test-Path $targFonts2)))) {
        $objFolder.CopyHere($File.fullname, 16)
        Write-Output " installed."
    } # Install Font
    else {
        Write-Output " exists."
    }


    #     $objFolder.CopyHere($File.fullname, 0x10)
}