# labwcpipemenus


## Window list menus

So hear me out, I don't want to use a panel or dock or anything, I just want to go back, way back to the old days, but I do *need* access to a list of windows I have open somehow....

### Sounds reasonable, but why so many that do the same thing?

I'm just trying to figure it out, some tools are more experimental (like lswt) and less easily available.

### What's the catch?

If there are multiple windows with the same name and id (possibly terminals, maybe file managers) there can be an element of chance as to if it raises the right one, this is reasonably well minimised by querying the state as well as the id and title, lswt has an unique identifier option which might prove useful in the future... This is ever so slightly less likely to happen using app-list-q.sh.

### Whatever, which 'app-list' do I use and why?

#### It depends... 
![image](app-list-cut.png)

[app-list-cut.sh](app-list-cut.sh) - this uses lswt and wlrctrl and uses cut (will only work with lswt 2.*) - supports minimised, active, fullscreen and maximised window identification as well as the ability to manually exclude certain windows from the list, maybe fastest of them all, it's the one I use and I consider the 'best'.

![image](app-list.png)

[app-list.sh](app-list.sh) - this only uses wlrctrl, which is widely available in most distributions, it also splits the window lists into minimised and viewable rather than in one list mixed up, but only shows if a window is minimised or not. It supports manually excluding apps from the list too. It has the least obscure app 'dependencies' so should work on most systems without having to build anything - IS SLOW


## So what else is there?

### [labwcfav.sh](labwcfav.sh)

This dubious script will make a pipemenu from your 'pinned' apps in gnome (the stuff in the dock/dash) - might be useful if you switch between gnome and labwc or something. 

