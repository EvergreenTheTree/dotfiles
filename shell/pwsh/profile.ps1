Invoke-Expression (&starship init powershell)

Import-Module posh-git

Set-PSReadLineOption -EditMode emacs
Set-PSReadLineOption -ExtraPromptLineCount 1

# Shows navigable menu of all options when hitting Tab
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
