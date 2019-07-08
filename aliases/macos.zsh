
# macos-only aliases
if [ "$(uname -s)" = "Darwin" ]
then
	# IP addresses
	alias localip="ipconfig getifaddr en0"

	# Lock the screen (when going AFK)
	alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

	# Airport CLI alias
	alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

	# Show/hide hidden files in Finder
	alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
	alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

	# Hide/show all desktop icons (useful when presenting)
	alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
	alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

	# Recursively delete `.DS_Store` files
	alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

	# Empty the Trash on all mounted volumes and the main HDD.
	# Also, clear Apple’s System Logs to improve shell startup speed.
	# Finally, clear download history from quarantine. https://mths.be/bum
	alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

	# Flush Directory Service cache
	alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

	# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
	alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'
fi