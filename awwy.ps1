#!/bin/env pwsh
param(
    [Parameter(Mandatory = $true)]
    [string]$Command,
    [Parameter(Mandatory = $false)]
    [string]$Name,
    [Parameter(Mandatory = $false)]
    [string]$OnlyFilePrefix = ""
)

$ErrorActionPreference = "Stop"
$ThisScriptFolderPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$libPath = [System.IO.Path]::Combine($ThisScriptFolderPath, "build", "_deps", "awwlib-src", "libawwy")
Write-Host "`$libPath=$($libPath)"

$COMMAND_HELP = "help"
$COMMAND_MDTREE = "mdtree"
$COMMAND_BUILD_RELEASE = "build-release"
$COMMAND_BUILD_DEBUG = "build-debug"
$COMMAND_CLANG_FORMAT_AUTOFIX = "clang-format-autofix"
$COMMAND_GET_GIT_UNPUSHED_CHANGES = "get-git-unpushed-changes"

$HELP_MESSAGE = @"
Usage:
   awwy.ps1 -Command <command> -Name <component_name>
   aww run awwy -Command <command> -Name <component_name>

Commands:
    $($COMMAND_HELP):
      Shows this help message

    $($COMMAND_MDTREE) [-OnlyFilePrefix <prefix>]:
      Generates a markdown documentation for C++ files.
        - OnlyFilePrefix: Generates documentation only for files that have the specified prefix in their name.

    $($COMMAND_BUILD_RELEASE):
      Builds the project using platform-specific build scripts and runs unit tests.

    $($COMMAND_BUILD_DEBUG):
      Builds the project using platform-specific build scripts and runs unit tests.

    $($COMMAND_CLANG_FORMAT_AUTOFIX):
        Automatically formats source code files using clang-format.
    $($COMMAND_GET_GIT_UNPUSHED_CHANGES):
        Get unpushed changes in the current branch.
"@

. $libPath/Get-Platform.ps1
. $libPath/Invoke-Build.ps1
. $libPath/Create-MDTREE.ps1
. $libPath/Invoke-ClangFormatAutofix.ps1
. $libPath/Get-GitUnpushedChanges.ps1


switch ($Command.ToLower()) {
    $COMMAND_HELP {
        Write-Host $HELP_MESSAGE
    }

    $COMMAND_MDTREE {
        Create-MDTREE -OnlyFilePrefix $OnlyFilePrefix
    }

    $COMMAND_BUILD_DEBUG {
        Invoke-Build -BuildType "Debug"
    }

    $COMMAND_BUILD_RELEASE {
        Invoke-Build -BuildType "Release"
    }

    $COMMAND_CLANG_FORMAT_AUTOFIX {
        Invoke-ClangFormatAutofix
    }

    $COMMAND_GET_GIT_UNPUSHED_CHANGES {
       Get-GitUnpushedChanges | Set-Clipboard
       Write-Host "Unpushed changes copied to clipboard"
    }

    Default {
        Write-Host $("=" * 80) -ForegroundColor Red
        Write-Host "Unknown command: $Command" -ForegroundColor Red
        Write-Host $("=" * 80) -ForegroundColor Red
        Write-Host $HELP_MESSAGE
        exit 1
    }
}

Write-Host "Done: $(Get-Date -Format o)"
