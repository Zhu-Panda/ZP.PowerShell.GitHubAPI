Function ZP-AccessGitHubAPI
{
    [CmdletBinding(PositionalBinding = $False)]
    Param
    (
        [Parameter(ParameterSetName = "CreateRepo")][Switch]$CreateRepo,
        [Parameter(ParameterSetName = "DeleteRepo")][Switch]$DeleteRepo,
        [Parameter(ParameterSetName = "CreateRepo")]
        [Parameter(ParameterSetName = "DeleteRepo")][String]$RepoName
    )
    If (-Not (Get-Command curl))
    {
        Write-Error "cURL not found. Please install it first as this function depends on it."
    }
    If ($CreateRepo)
    {
        curl -u "$($ZPConfig.GitHub.Username):$($ZPConfig.GitHub.PAT)" -d "{\`"name\`":\`"$($RepoName)\`"}" https://api.github.com/user/repos
    }
    ElseIf ($DeleteRepo)
    {
        curl -u "$($ZPConfig.GitHub.Username):$($ZPConfig.GitHub.PAT)" -X DELETE "https://api.github.com/repos/$($ZPConfig.GitHub.Username)/$($RepoName)"
    }
    Else {
        Write-Error "Unknown action specified. Please specify action."
    }
}