on run argv
	
	tell application "iTunes"
		
		set albumName to item 1 of argv
		
		set itunesLibrary to a reference to library playlist 1
		set albumList to (every track of itunesLibrary where (album is albumName))
		
		# except not music track
		set noMusic to -1
		repeat with t in albumList
			if (time of t) is missing value then
				set noMusic to id of t
			end if
		end repeat
		
		
		play (every track of itunesLibrary whose (id is not noMusic) and (album is albumName))
	end tell
end run