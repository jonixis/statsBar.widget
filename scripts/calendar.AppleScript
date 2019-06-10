#!/usr/bin/osascript
-- calendar from which to ignore events
set TASKS_CALENDAR to "Toodledo iCal"
-- the current timestamp
set now to (current date)
-- midnight this morning
set today to now - (time of now)
-- midnight tomorrow morning
set tomorrow to (today) + (24 * 60 * 60)
-- list of output lines
set output to {}
tell application "iCal"
	-- iterate relevant calendars
	repeat with c in (every calendar whose (name) is not TASKS_CALENDAR)
		-- iterate upcoming tasks, excepting repeating tasks not repeating today
		repeat with e in ((every event in c) whose (start date) is greater than or equal to today and (start date) is less than tomorrow and (start date) is not in (excluded dates))
			-- properly note tasks lasting all day
			if (allday event of e) then
				set output to output & ("All Day: " & (summary of e))
			else
				set startDate to (start date of e)
				set endDAte to (end date of e)
				set startTime to (time string of startDate)
				set endTime to (time string of endDAte)
				if (count of startTime) is less than 11 then
					set startTime to " " & startTime
				end if
				if (count of endTime) is less than 11 then
					set endTime to " " & endTime
				end if
				set output to output & (startTime & " - " & endTime & "  " & (summary of e))
			end if
		end repeat
	end repeat
end tell
-- join output strings with newlines
set AppleScript's text item delimiters to return
output as text
return output
