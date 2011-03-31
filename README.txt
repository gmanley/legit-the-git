`gem install legit-the-git`

Usage legit-the-git [--version] [--help] <command>

Commands:
  install      Install the Accurev Git hook into the current directory
  uninstall    Remove legit-the-git from the current repo

Workflow:
  Once installed commit your changes like usual. When you would like to push
  those changes to accurev, just run `git push accurev`. This will sync new
  commits from the current branch to the accurev server. Just make sure you
  are logged into accurev!

Released under the MIT License (See LICENSE.txt file).

Copyright (c) 2011 Grayson Manley