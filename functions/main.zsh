# Some general functions
#
#


# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

function cclean() { 

	if [ "$(uname -s)" = "Darwin" ]; then
		echo "Clearing caches and trash..."
		# clean caches and trash
		dirs=(/Library/Caches ~/Library/Caches ~/.Trash)
		for d in $dirs
		do
			if [ -d "$d" ]; then
				sudo rm -rf "$d"/*
			fi
		done

		echo "Flushing DNS cache..."
		sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed
	fi
}

function findinfile() { 
	if [ "$#" -ne 2 ]; then
		echo "Usage: findinfile DIR SEARCHTEXT"
	fi
	local searchdir=$1
	local searchtxt=$2

	find "$1" -type f -exec fgrep -H "$2" {} \;
}