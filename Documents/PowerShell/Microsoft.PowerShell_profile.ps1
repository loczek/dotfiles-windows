oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/lambda.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

# Set-PSReadLineOption -PredictionViewStyle ListView

# Set-Location F:\dev

Function DotfilesFunc { git --git-dir=$Home/.dotfiles/ --work-tree=$HOME @Args }
Set-Alias -Name dotfiles -Value DotfilesFunc