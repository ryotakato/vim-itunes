
tell application "iTunes"
	
	with timeout of 300 seconds
		
		# the list we'll populate
		set listOfAlbumNames to {}
		set itunesLibrary to a reference to library playlist 1
		# (get view of front window)
		set totalNumberOfTracks to (count of every track in itunesLibrary)
		
		# loop through each track, adding unique album names to the list    
		repeat with i from 1 to totalNumberOfTracks
			try
				set currentTrack to (a reference to track i of itunesLibrary)
				set currentAlbumName to (currentTrack's album as string) & "	" & (currentTrack's album artist as string)
				if currentAlbumName is not "" then
					if listOfAlbumNames does not contain currentAlbumName then
						copy currentAlbumName to end of listOfAlbumNames
					end if
				end if
			end try
		end repeat
		
	end timeout
	
end tell


set retAlbums to ""

repeat with a in listOfAlbumNames
    # add CR/LF
	set retAlbums to retAlbums & "
" & a
end repeat

# display in a dialog
return retAlbums
