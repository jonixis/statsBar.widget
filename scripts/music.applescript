set trackName to null
set artistName to null

tell application "System Events" to set MusicProcess to the count of (processes whose name is "Music")

if MusicProcess is not 0 then
  tell application "Music"
    if player state is playing then
       try
          set trackName to (name of current track)
          set artistName to (artist of current track)
       on error
          set trackName to "n/a"
          set artistName to "n/a"
       end try
    end if
  end tell
end if

return trackName & "@" & artistName

