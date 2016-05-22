---
title: "Suppress Startup Sound on Mac OSX"
date: 2016-04-18 22:05:00 +0800
categories: [technologies]
tags: [Mac]
author: Kevin
---

Are you constantly scared by the startup sound when you start your Mac or feel awkward when the sound annoys people around you when you use your Mac in a public place? Here are two scripts that can save you - one mute the Mac when log out OSX and the other one unmute your Mac after you log in. 

Here are the steps:

* Create the script to mute the Mac: `sudo nano /Library/Scripts/mute.sh`

        #!/bin/bash
        
        osascript -e 'set volume output muted 1'
    
* Create the script to unmute the Mac: `sudo nano /Library/Scripts/unmute.sh`

        #!/bin/bash
            
        osascript -e 'set volume output muted 0'
        
* Add execute permission to the scripts

    `sudo chmod u+x /Library/Scripts/mute.sh`
    
    `sudo chmod u+x /Library/Scripts/umute.sh`
        
* Add the two scripts to login and logout hook respectively

    `sudo defaults write com.apple.loginwindow LogoutHook /Library/Scripts/mute.sh`
    
    `sudo defaults write com.apple.loginwindow LoginHook /Library/Scripts/unmute.sh`
    
* If you want to undo the changes

    `sudo defaults delete com.apple.loginwindow LoginHook`
    
    `sudo defaults delete com.apple.loginwindow LogoutHook`
        
