# Bar Controls

![](https://drive.slawagurevich.com/zbarcontrols.png)

## What's this?

BarControl is an(other) app to control your iTunes / Music App from the status bar of your Mac. Additionally, it can display the currently playing song and let you change some payback options, as well as the playback position.

## Why does this exist?

(No, really?)

Yes, I know, what you are going to say. "There are already tons of apps that let you do that!" And to that I say: Great! Go ahead and use one of them ;) But because there _are_ so many apps, everybody gets a shot at this and in my opinion a lot of these apps won't let you customise many things, have a questionable design or are just outdated. And while this app is far from perfect, I tried to make it as customisable as possible (and am continuing to do so).

Please be ware, that this is still a WiP / Beta and a there are quite some bugs in the app. If you find any (besides the ones I listed down bellow), please let me know in the issues and I will try to work on them.

## Features
- Show currently Playing song in the status bar
- Choose, which elements are shown in the status bar (You can toggle ✅ Title, ✅ Artist, ✅ Album
- Select what happens on click / right click (✅ Show Popup, ✅ Show Menu, ✅ Play/Pause, ✅ Skip Track, ✅ Previous Track)
- Change the Shuffle Mode (On / Off)
- Change Repeat Mode (One / All / Off)

## Known Bugs
- If you start the app for the first time without having iTunes / Music open, it may crash
- Start at startup isn't currently working
- The app has a small memory leakage problem because of the ScriptingBridge library. This is apparently not fixable, but I hope, it doesn't get out of hand...
- The app itself is not signed yet. I may sign it when I'm finished, but for now it's mostly a WiP project. So please allow it to run in the security settings, if you'd like to use it.

## Acknowledgements

This is app is using the [itunescli Library (File) created by Bart Simons](https://github.com/bmsimons/itunescli).
