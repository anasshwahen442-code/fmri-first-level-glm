# Usage (from this folder, in PowerShell):  .\publish.ps1
# Requires Git for Windows. Authentication happens through Git Credential Manager (browser sign-in); no token is stored in this file.
$ErrorActionPreference = "Stop"
$Repo   = "https://github.com/anasshwahen442-code/fmri-first-level-glm.git"
$Branch = "main"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "Git is not installed: https://git-scm.com/download/win" }

if (-not (Test-Path ".git")) { git init -b $Branch }
if (-not (git remote)) { git remote add origin $Repo } else { git remote set-url origin $Repo }

# Commit in logical steps so the history shows what was done and when
git add .gitignore requirements.txt
git commit -m "Add requirements and .gitignore" 2>$null
git add fmri_first_level_glm.ipynb
git commit -m "Add GLM, group and ROI analysis notebook" 2>$null
git add README.md figures results
git commit -m "Add README, figures and result tables" 2>$null

git push -u origin $Branch
Write-Host "Done: https://github.com/anasshwahen442-code/fmri-first-level-glm"
