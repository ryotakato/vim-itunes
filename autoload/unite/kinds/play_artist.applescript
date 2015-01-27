on run argv
	
	tell application "iTunes"
		
		set artistName to item 1 of argv
		
		set itunesLibrary to a reference to library playlist 1
		set artistList to (every track of itunesLibrary where (album artist is artistName))
		
		# except not music track
		set noMusic to -1
		repeat with t in artistList
			if (time of t) is missing value then
				set noMusic to id of t
			end if
		end repeat
		
		
		play (every track of itunesLibrary whose (id is not noMusic) and (album artist is artistName))
	end tell
end run
