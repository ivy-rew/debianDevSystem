# HP Scanner

Based on Ubuntu 22.04 most HP scanners are not working, altough these are recognized and listed as scanners. 
Even so, printing works flawlessly

# fix it:

1. `sudo apt install hplip-gui`
1. run `hp-toolbox`
1. select the printer and run the 'scan' action
1. scanning will fail
1. however, an installer will ask to install proprietary drivers from HP
1. accept; install from HP servers; grant sudo
1. scan again: it should work now :)
1. mint: launch 'startup and applications' > untoggle "hp system tray"
