#!/usr/bin/env pwsh
#
# idle_timeout.ps1 — Windows / PowerShell sibling of idle_timeout.sh.
#
# Runs a command under TWO caps, and returns 124 for either (the GNU `timeout`
# convention):
#
#   * the IDLE-OUTPUT watchdog — no new output for IdleSeconds. Catches a
#     wedged transport that stalls mid-run AND a cold hang that never reaches
#     the first test. See the header of idle_timeout.sh for the full rationale.
#   * the WALL-CLOCK backstop — the command has simply run too long, whatever
#     it has been printing. SCE148.
#
# WHY THE WALL CLOCK LIVES HERE AND NOT IN THE RUNNERS. On the shell side the
# runners compose two tools, `idle_timeout.sh N log -- timeout 900 flutter
# test`, because GNU `timeout` exists. PowerShell has no such binary, so the
# equivalent has to be built, and building it once in the watchdog gives all
# three .ps1 runners the same cap with the same process-tree kill instead of
# three hand-rolled ones that drift. A cap that kills only the parent leaves
# the companion app running and the next file racing it, which is the
# corruption the serial rule exists to prevent.
#
# A RUN CAN OUTLIVE THE IDLE WATCHDOG AND STILL BE STUCK: an infinite loop that
# keeps printing resets the idle timer for ever. That is the case this cap is
# for, and it is why raising the idle default to 300 (SCD131) left Windows with
# a weaker guarantee than the shell runners until now.
#
# THE TWO KILLS ARE DISTINGUISHED IN THE LOG, not by exit code. Both return 124
# because that is what a caller checking for "timed out" reads, so the marker
# line the wrapper writes is what says WHICH — and the runners read it to
# annotate the metrics line. Reporting a wall-clock kill as
# `(IDLE-KILLED after 300s of no output)` would be a false statement about a
# run that was producing output the whole time.
#
# Usage:
#   idle_timeout.ps1 <IdleSeconds> <LogFile> <command> [args...]
#
# Override the wall clock with $env:WALL_TIMEOUT (seconds; 0 disables it).
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
# 900 to match the shell runners' `timeout 900`. 0 disables, which is what a
# deliberate long sweep wants rather than a large number nobody can tell from a
# typo.
$wall = if ($env:WALL_TIMEOUT) { [int]$env:WALL_TIMEOUT } else { 900 }

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
$wallKilled = $false
$started = Get-Date
while (-not $proc.HasExited) {
  Start-Sleep -Seconds $poll
  Receive-Job $mirror -ErrorAction SilentlyContinue | Out-Host
  if ($wall -gt 0 -and ((Get-Date) - $started).TotalSeconds -ge $wall) {
    $wallKilled = $true
    # Same tree kill as the idle path: cmd.exe + flutter + any child.
    & taskkill /T /F /PID $proc.Id 2>$null | Out-Null
    break
  }
  $mt = (Get-Item $LogFile).LastWriteTime
  if (((Get-Date) - $mt).TotalSeconds -ge $IdleSeconds) {
    $idleKilled = $true
    # Kill the whole tree (cmd.exe + flutter + any child it spawned).
    & taskkill /T /F /PID $proc.Id 2>$null | Out-Null
    break
  }
}

$proc.WaitForExit()
Start-Sleep -Milliseconds 300

# THE MARKER IS WRITTEN AFTER THE PROCESS IS DEAD, and that is not tidiness.
#
# SCE148 measured this: `cmd /c "... > LOG 2>&1"` holds LOG open with its own
# file position, so an `Add-Content` from here while cmd is still running is
# either refused or overwritten by cmd's next write. The marker therefore never
# reached the log — including the IDLE marker, which had been written this way
# since the file was created and which nothing had ever checked for. The probe
# that found it is in the todo; the symptom was a kill with the right exit code
# and no explanation in the file.
#
# Appending once the tree is gone has no such contention, and the marker is for
# the reader and the runner's metrics line rather than for the live console.
if ($wallKilled) {
  Add-Content -Path $LogFile -Value "== wall_timeout: ran for >=${wall}s - killed test run (pid $($proc.Id)) =="
}
if ($idleKilled) {
  Add-Content -Path $LogFile -Value "== idle_timeout: no output for >=${IdleSeconds}s - killed test run (pid $($proc.Id)) =="
}
Receive-Job $mirror -ErrorAction SilentlyContinue | Out-Host
Stop-Job $mirror -ErrorAction SilentlyContinue
Remove-Job $mirror -Force -ErrorAction SilentlyContinue

if ($idleKilled -or $wallKilled) { exit 124 }
exit $proc.ExitCode
