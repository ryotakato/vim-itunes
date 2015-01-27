
tell application "iTunes"
	
	with timeout of 300 seconds
		
		# the list we'll populate
		set listOfArtistNames to {}
		set itunesLibrary to a reference to library playlist 1
		# (get view of front window)
		set totalNumberOfTracks to (count of every track in itunesLibrary)
		
		# loop through each track, adding unique artist names to the list    
		repeat with i from 1 to totalNumberOfTracks
			try
				set currentTrack to (a reference to track i of itunesLibrary)
				set currentArtistName to (currentTrack's album artist as string)
				if currentArtistName is not "" then
					if listOfArtistNames does not contain currentArtistName then
						copy currentArtistName to end of listOfArtistNames
					end if
				end if
			end try
		end repeat
		
	end timeout
	
end tell


set retArtists to ""

repeat with a in listOfArtistNames
    # add CR/LF
	set retArtists to retArtists & "
" & a
end repeat

# display in a dialog
return retArtists
