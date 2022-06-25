# Checks for docker-compose command as that is required
if ((Get-Command "docker-compose" -ErrorAction SilentlyContinue) -eq $null) {
    Write-Error "Docker isn't installed. Please install"
    exit 1
  }

# Write out the docker compose command line
Write-Host "`nRunning" $dockerComposeFilesToRun -ForegroundColor Green

# Settings
$databaseEngine = "pg"
$projectName = Split-Path -Path $PSScriptRoot -Leaf

$dockerComposeFilesToRun = "-f docker-compose.server.yml -f docker-compose.$databaseEngine.yml"
$dockerComposeFilesToRun = $dockerComposeFilesToRun + " --env=./.env -p $projectName";
$dockerComposeFilesToRun = $dockerComposeFilesToRun + ' up --build'

Start-Process -FilePath "docker-compose" -Wait -ArgumentList $dockerComposeFilesToRun -WorkingDirectory $PSScriptRoot -NoNewWindow