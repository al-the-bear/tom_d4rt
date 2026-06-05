#!/usr/bin/env pwsh
#
# idle_timeout.ps1 — Windows / PowerShell sibling of idle_timeout.sh.
#
# Runs a command with an IDLE-OUTPUT watchdog: if the command produces NO new
# output for IdleSeconds, the whole process tree is killed and 124 is returned
# (the GNU `timeout` convention). This catches both a wedged transport that
# stalls mid-run AND a cold hang that never reaches the first test, so a stuck
# run fails fast instead of burning the per-file wall-clock backstop. See the
# header of idle_timeout.sh for the full rationale.
#
# Usage:
#   idle_timeout.ps1 <IdleSeconds> <LogFile> <command> [args...]
#
# Stall detection polls the logfile's LastWriteTime (fd-agnostic, like the bash
# sibling). Output is merged (stdout+stderr) into the logfile via cmd.exe and
# mirrored live to the console.
param(
  [Parameter(Mandatory = $true)][int]$IdleSeconds,
  [Parameter(Mandatory = $true)][string]$LogFile,
  [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)][string[]]$Command
)

$ErrorActionPreference = 'Continue'
$poll = if ($env:IDLE_POLL) { [int]$env:IDLE_POLL } else { 5 }

# Create/truncate the logfile up front so the mtime poll and live mirror have a
# file to attach to with no race.
Set-Content -Path $LogFile -Value $null

# Merge stdout+stderr into the logfile via cmd.exe, so the file is the single
# source for both the run's output and the summary grep (matches the bash
# wrapper). flutter on Windows is flutter.bat — cmd /c resolves it.
$inner = ($Command -join ' ')
$proc = Start-Process -FilePath $env:ComSpec `
  -ArgumentList @('/c', "$inner > `"$LogFile`" 2>&1") `
  -NoNewWindow -PassThru

# Live console mirror: a job tailing the logfile while the process runs.
$mirror = Start-Job -ScriptBlock { param($lf) Get-Content -Path $lf -Wait } -ArgumentList $LogFile

$idleKilled = $false
while (-not $proc.HasExited) {
  Start-Sleep -Seconds $poll
  Receive-Job $mirror -ErrorAction SilentlyContinue | Out-Host
  $mt = (Get-Item $LogFile).LastWriteTime
  if (((Get-Date) - $mt).TotalSeconds -ge $IdleSeconds) {
    Add-Content -Path $LogFile -Value "== idle_timeout: no output for >=${IdleSeconds}s - killing test run (pid $($proc.Id)) =="
    $idleKilled = $true
    # Kill the whole tree (cmd.exe + flutter + any child it spawned).
    & taskkill /T /F /PID $proc.Id 2>$null | Out-Null
    break
  }
}

$proc.WaitForExit()
Start-Sleep -Milliseconds 300
Receive-Job $mirror -ErrorAction SilentlyContinue | Out-Host
Stop-Job $mirror -ErrorAction SilentlyContinue
Remove-Job $mirror -Force -ErrorAction SilentlyContinue

if ($idleKilled) { exit 124 }
exit $proc.ExitCode
