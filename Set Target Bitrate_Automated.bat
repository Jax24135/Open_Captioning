:: Takes a video file and ASS caption file
:: Creates 2 open-captioned versions

@echo off

::clears the screen
cls

::starts PGRM --legacy?
:start

set /p target_bitrate="Enter video bitrate (MB): "

:: for every file (%%~nA) in current directory ('...') that matches .mp4 extension
FOR /F %%A IN ('dir /b *.mp4') DO (
	:: TETO -- echo filename
	::set vidName=%%~nA

	:: run FFMEPG on every file and burn in the matching ASS captionfile
	:: make video birate 10M	|| make audio 192kbps
	:: end new file with "_captioned.mp4"
	"C:\ffmpeg\bin\ffmpeg" -i "%%~nA.mp4" -b:v "%target_bitrate%M" -b:a 192k -vf ass="%%~nA.ass" -loglevel info -threads 4 "%%~nA_captioned.mp4"
)

::give User a chance to see error/success message
echo.
echo Finished. Hit any key to exit.

pause > nul


::exit PRGM
:exit