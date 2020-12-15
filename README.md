# alfred-rdp-workflow
Simple workflow to open Bookmarks from Microsoft Remote Desktop, based on https://github.com/ctwise/alfred-workflows/tree/master/remote-desktop

# Why?
The version that was in the source repository was no longer maintained and was no longer functional. It also relied on using osascript to open 'Microsoft Remote Desktop', bring it to the foreground and simulate keypresses to open the session. This was not always working flawlessly.

# How?
Two parts:
- list_desktops.rb: Accepts one command line argument, the hostname, and uses the build in script option of the Microsoft Remote Desktop App to display the bookmarks in csv format. Then it searches for the hostname and returns that back to alfred via ./alfred_feedback.rb. This allows the user to search through the different bookmarks.

![rdp alfread search](https://imgur.com/ubdLdBw)

- open_desktop.rb: Accepts one command line argument, the hostname, and uses the build in script option of the Microsoft Remote Desktop App to display the bookmarks in csv format. Then it searches for the hostname and uses the export option of the Microsoft Remote Desktop App to get the rdp:// url. It then calls the rdp url and the session opens.

# Todo:

- Merge code into one file as there is code duplication now.
- Add tests

# Installation
You can compile it from source or download the latest binary from the releases page.

https://github.com/frank-m/alfred-rdp-workflow/releases
