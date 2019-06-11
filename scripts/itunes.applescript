set trackName to null
set artistName to null

tell application "System Events" to set iTunesProcess to the count of (processes whose name is "iTunes")

if iTunesProcess is not 0 then
	tell application "iTunes"
		if player state is playing then
			set trackName to (name of current track)
			set artistName to (artist of current track)
		end if
	end tell
end if

return trackName & "@" & artistName
