# hammerspoon-microphone-ptt
Hammerspoon config snippet to enable Push-To-Talk on input devices

Mutes all your input devices on config initialisation.
Binds "Fn" and "Mouse Forward" buttons to mute/unmute all input devices

If your microphone is stuck muted, go to `System Preferences -> Sound -> Input` and change the volume of your microphone - that will unmute it.
You will also have to unmute manually after removing the code snippet and realoading hammerspoon config if you no longer want to use it.

# Known issues:
- MS Teams adds a HUGE "Your microphone is muted" banner right in the middle of the call screen - it covers most of the call window (and whole of the small "detached" one when you had another window on top). Banner can be closed, but it will appear again when you mute next time. Currently MS Teams has no option to disable the banner

# Rudimentary setup:

- `local pushToTalk = [true/false]`
  - if set to `True`, pressing Fn or Mouse Forward will unmute, releasing will mute again.
  - if set to `False`, pressing Fn or Mouse Forward will unmute. Press again to mute.

- `local suppressFnKey = [true/false]`
  - if set to `True`, muting/unmuting Teams with Fn key will not send the Fn key (e.g. Fn+Backspace will no longer work).
  - if set to `False`, muting/unmuting Teams with Fn key will also send the Fn key to the top-most window.

- `local suppressMouseForward = [true/false]`
  - if set to `True`, muting/unmuting Teams with Mouse Forward will not send the Mouse Forward button itself.
  - if set to `False`, muting/unmuting Teams with Mouse Forward will also send the Mouse Forward button to top-most window.

# Installation
- install hammerspoon from http://www.hammerspoon.org/
- click the hammerspoon menubar icon, click `Open Config`
- copy contents of the `config snippet.lua` file into your hammerspoon config
- click the hammerspoon menubar icon, click `Reload Config`
- your microphones will be muted and text in menubar will show mute status - `Fn` and `Mouse Forward (4)` button will mute/unmute microphones

# Changelog
- 18/06/2021 - initial release
