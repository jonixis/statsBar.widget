tell application "System Events" to set mailProcess to the count of (processes whose name is "Mail")

if mailProcess = 0 then
	set message_count to null
else
	tell application "Mail"
		set unreadMessages to (messages of inbox whose read status is false)
		set message_count to number of items in unreadMessages
	end tell
end if

return message_count

