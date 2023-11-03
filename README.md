# Sound Switcher - Version 0.0.1

## Initial purpose

This project was made to easily switch between 2 output devices.
For the initial usecase, it was to easily switch between headphones and speakers while playing video games.

This application is only designed to work on Windows.
This application is exclusively written in powershell.
Feel free to fork it and add features or other OSes compatibility.

## Documentation
To start the application, use the compiled version (SoundSwitcher.exe)
To test the project, run the `main.ps1` using 

`powershell main.ps1`

## main.ps1
This file is the entrypoint of the appplication. It contains the possible params and the result of them.

## setup_popup.ps1
This file is used during the setup phase (first startup).
It allow the user to choose 2 audio devices, which will be switched during the next execution of the application.

## SoundSwitch.ps1
This file contains the logic to switch between audio devices.