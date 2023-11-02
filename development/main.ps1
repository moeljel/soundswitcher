if ($args.Length -gt 0) {
    switch ($args[0]) {
        'help' {
            Write-Output "SoundSwitch is an open-source application created by Mohamed El Jelali to help users switch between 2 audio output devices.
            Commands:
            [help]: Show this help message
            [reset]: Reset the choices made at the first startup
            "
        }
        'reset' {
            Remove-Item .\choices.txt
        }
    }
} else {
    powershell .\SoundSwitch.ps1
}