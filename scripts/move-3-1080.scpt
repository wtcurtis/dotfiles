on move_process(process_name, x, y, w, h)
	tell application "System Events"
		tell process process_name
			try
				with timeout of 1 second
					repeat with wnd from 1 to (count windows)
						set position of window wnd to {x, y}
						set size of window wnd to {w, h}
					end repeat
				end timeout
			on error the errorMessage
				log errorMessage
			end try
		end tell
	end tell
end move_process

on move_app(app_name, x, y, w, h)
    try
        tell application app_name
            repeat with wnd from 1 to (count windows)
                set bounds of window wnd to {x, y, w, h}
            end repeat
        end tell
    on error the errorMessage
        log errorMessage
    end try
end move_app

move_process("goland", 1920, 0, 1920, 1080)
move_process("phpstorm", 1920, 0, 1920, 1080)
move_process("datagrip", 1920, 0, 1920, 1080)
move_process("Slack", 3940, 100, 1720, 800)
move_process("iTerm2", 1920, 0, 1920, 1080)
move_app("Google Chrome", 1, 1, 1920, 1200)

