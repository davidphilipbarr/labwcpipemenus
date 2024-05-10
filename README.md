# labwcpipemenus


## What is all this shit?


So hear me out, I don't want to use a panel or dock or anything, I just want to go back, way back to the old days, but I do *need* access to a list of windows i have open somehow....


### Sounds reasonable, but why so many that do the same thing?

I'm just trying to figure it out, some tools are more experimental (like lswt) and less easily available to install.

### Whatever, which 'app-list' do I use and why?

#### Pobably this one:
[app-list.sh](app-list.sh) - this only uses wlrctrl, which is widely available in most distributions, it also splits the window lists into minimised and viewable rather than in one list mixed up, but only shows if a window is minimised or not. It has the least obscure app 'dependencies' so should work on most systems without having to build anything.   

#### The others
app-list-cut.sh - this uses lswt and wlrctrl and uses cut (doesn't require jq and will only work at the moment with GIT lswt) - supports minimised and active window identification as well as the ability to manually exclude certain windows from the list.

app-list-lswt-json.sh - this uses lswt and wlrctrl and jq for parsing the output from lswt (will work better with older versions of lswt)  - supports minimised and active window identification.

app-list-q.sh - slight variation on the above. 

app-list-term.sh -  mostly the same as app-list.sh but splits out terminals into their own menu to avoid clutter, if you use a lot of terminals.

There are some other quirks here and there like hiding and showing seperators depending on requirements, but they do involve extra queries which might slow it down.

