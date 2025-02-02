oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/lambda.omp.json" | Invoke-Expression

function dotfiles { git --git-dir=$Home/.dotfiles/ --work-tree=$HOME @Args }

# up and down arrow keys to search in history
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# tab style completions
Set-PSReadLineKeyHandler -Key Tab -Function Complete

# Import Terminal Icons
Import-Module -Name Terminal-Icons

# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

function cd...  { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }
function md5    { Get-FileHash -Algorithm MD5 $args }
function sha1   { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }
function n      { notepad $args }
function HKLM:  { Set-Location HKLM: }
function HKCU:  { Set-Location HKCU: }
function Env:   { Set-Location Env: }

# Does the the rough equivalent of dir /s /b. For example, dirs *.png is dir /s /b *.png
function dirs
{
    if ($args.Count -gt 0)
    {
        Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
    }
    else
    {
        Get-ChildItem -Recurse | Foreach-Object FullName
    }
}

# Simple function to start a new elevated process. If arguments are supplied then
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started.
function admin
{
    if ($args.Count -gt 0)
    {
       $argList = "& '" + $args + "'"
       Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
    }
    else
    {
       Start-Process "$psHome\powershell.exe" -Verb runAs
    }
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command
# with elevated rights.
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin


# Make it easy to edit this profile once it's installed
function Edit-Profile
{
    if ($host.Name -match "ise")
    {
        $psISE.CurrentPowerShellTab.Files.Add($profile.CurrentUserAllHosts)
    }
    else
    {
        notepad $profile.CurrentUserAllHosts
    }
}

# We don't need these any more; they were just temporary variables to get to $isAdmin.
# Delete them to prevent cluttering up the user profile.
Remove-Variable identity
Remove-Variable principal

Function Test-CommandExists
{
 Param ($command)
 $oldPreference = $ErrorActionPreference
 $ErrorActionPreference = 'SilentlyContinue'
 try {if(Get-Command $command){RETURN $true}}
 Catch {Write-Host "$command does not exist"; RETURN $false}
 Finally {$ErrorActionPreference=$oldPreference}
}
#
# Aliases
#
# If your favorite editor is not here, add an elseif and ensure that the directory it is installed in exists in your $env:Path
#
if (Test-CommandExists zed) {
    $EDITOR='zed'
}elseif (Test-CommandExists code) {
    $EDITOR='code'
} elseif (Test-CommandExists nvim) {
    $EDITOR='nvim'
}  elseif (Test-CommandExists notepad) {
    $EDITOR='notepad'
}
Set-Alias -Name code -Value $EDITOR

function ll { Get-ChildItem -Path $pwd -File }
function g { Set-Location $HOME\Documents\Github }
function gcom
{
	git add .
	git commit -m "$args"
}
function lazyg
{
	git add .
	git commit -m "$args"
	git push
}
Function Get-PubIP {
 (Invoke-WebRequest http://ifconfig.me/ip ).Content
}
function uptime {
		$bootUpTime = Get-WmiObject win32_operatingsystem | Select-Object lastbootuptime
		$plusMinus = $bootUpTime.lastbootuptime.SubString(21,1)
        $plusMinusMinutes = $bootUpTime.lastbootuptime.SubString(22, 3)
        $hourOffset = [int]$plusMinusMinutes/60
        $minuteOffset = 00
        if ($hourOffset -contains '.') { $minuteOffset = [int](60*[decimal]('.' + $hourOffset.ToString().Split('.')[1]))}
          if ([int]$hourOffset -lt 10 ) { $hourOffset = "0" + $hourOffset + $minuteOffset.ToString().PadLeft(2,'0') } else { $hourOffset = $hourOffset + $minuteOffset.ToString().PadLeft(2,'0') }
        $leftSplit = $bootUpTime.lastbootuptime.Split($plusMinus)[0]
        $upSince = [datetime]::ParseExact(($leftSplit + $plusMinus + $hourOffset), 'yyyyMMddHHmmss.ffffffzzz', $null)
        Get-WmiObject win32_operatingsystem | Select-Object @{LABEL='Machine Name'; EXPRESSION={$_.csname}}, @{LABEL='Last Boot Up Time'; EXPRESSION={$upsince}}

        #Works for Both (Just outputs the DateTime instead of that and the machine name)
        net statistics workstation | Select-String "since" | foreach-object {$_.ToString().Replace('Statistics since ', '')}

}
function reload-profile {
        & $profile
}
function find-file($name) {
        Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
                $place_path = $_.directory
                Write-Output "${place_path}\${_}"
        }
}
function unzip ($file) {
        Write-Output("Extracting", $file, "to", $pwd)
	$fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object{$_.FullName}
        Expand-Archive -Path $fullFile -DestinationPath $pwd
}
function grep($regex, $dir) {
        if ( $dir ) {
                Get-ChildItem $dir | select-string $regex
                return
        }
        $input | select-string $regex
}
function touch($file) {
        "" | Out-File $file -Encoding ASCII
}
function df {
        get-volume
}
function sed($file, $find, $replace){
        (Get-Content $file).replace("$find", $replace) | Set-Content $file
}
function which($name) {
        Get-Command $name | Select-Object -ExpandProperty Definition
}
function export($name, $value) {
        set-item -force -path "env:$name" -value $value;
}
function pkill($name) {
        Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}
function pgrep($name) {
        Get-Process $name
}