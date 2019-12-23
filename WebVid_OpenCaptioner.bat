:: Takes an MP4 video file and ASS caption file
:: Creates 2 360p open-captioned video files

@echo off

::clears the screen
cls

::starts PRGM.bat
:start

echo.
echo Press CTRL+C to abort program.
echo.

::lists all files in directory
::run through (/b) filter, for (/a-d) all-non-directory \
::searching (/s) for any files ending in MP4 and ASS

echo Here are all the files in this directory you can use:
echo.

::dir /b /a-d /b /s *.mp4 *.ass
dir /b /s *.mp4 *.ass

echo.

:: real start of PRGM
echo Use TAB key to auto-complete file names
echo.

echo DO NOT include Quote Marks, use HOME and END keys to jump to file name beginning and end.
echo.

set /p videoFile="Enter MP4 file name (with extension, but REMOVE Quote Marks): "
echo.

::create $var for non-exten
set videoFileNoExt=%videoFile:~0,-4%

::DEBUG-proves $var was created
::echo "%videoFileNoExt%"

set /p captionFile="Enter ASS caption file name (with extension, but REMOVE Quote Marks): "



::create temporary file to make resolution 640x360, limitation of $vf --can do scaling or burning in... not both so far
"C:\ffmpeg\bin\ffmpeg" -i "%videoFile%" -vf scale="640:360" -b:v 5M -c:a copy -threads 3 "%videoFileNoExt%.tmp.mp4"

::embed subtitles into $VARs
::runs FFMPEG
						:: on an input file
										:: copies audio stream
												  :: shows progress of open-captioning
																		 ::controls bitrate
																				   ::sets output filename
::"C:\ffmpeg\bin\ffmpeg" -i "%videoFile%" -c:a copy -vf ass="%captionFile%" -crf 14 "%videoFileNoExt%_REV_HRcaptioned.mp4"
"C:\ffmpeg\bin\ffmpeg" -i "%videoFileNoExt%.tmp.mp4" -b:v 1.5M-c:a copy -vf ass="%captionFile%" -threads 3 -loglevel info "%videoFileNoExt%_REV_HRcaptioned.mp4"
"C:\ffmpeg\bin\ffmpeg" -i "%videoFileNoExt%.tmp.mp4" -b:v 0.45M -c:a copy -vf ass="%captionFile%" -threads 3 -loglevel info "%videoFileNoExt%_REV_LRcaptioned.mp4"


::delete temp file (resized video)
del "%videoFileNoExt%.tmp.mp4"

::give User a chance to see erorr/success message
echo.
echo Finished. Hit any key to exit.

echo.
echo Then type "exit" to quit terminal.
echo.
pause >nul


::exit Embedder.bat
:exit