#!/bin/bash

cd ~/ytdlwl
source ~/ytdlwl/ytdlwl/bin/activate

OUTPUT_PATH=~/shared/Videos/Youtube-WL

echo downloading playlist...
yt-dlp -J --cookies ~/ytdlwl/cookies/cookies.txt https://www.youtube.com/playlist?list=WL > ${OUTPUT_PATH}/playlist.json

echo purging...
python3 remove_videos_not_in_playlist.py ${OUTPUT_PATH} ${OUTPUT_PATH}/playlist.json

echo downloading files...
yt-dlp --embed-thumbnail --embed-metadata --embed-chapters --restrict-filenames -f "best[height=720]" --cookies ~/ytdlwl/cookies/cookies.txt --paths $OUTPUT_PATH https://www.youtube.com/playlist?list=WL 
#yt-dlp --embed-thumbnail --embed-metadata --embed-chapters --cookies ~/ytdlwl/cookies/cookies.txt --paths $OUTPUT_PATH https://www.youtube.com/playlist?list=WL 
#yt-dlp --embed-thumbnail --embed-metadata --embed-chapters -f "bv*[height<=1080]+ba/b[height<=1080] / wv*+ba/w" --cookies ~/ytdlwl/cookies/cookies.txt --paths $OUTPUT_PATH https://www.youtube.com/playlist?list=WL 
#yt-dlp --embed-thumbnail --embed-metadata --embed-chapters -S 'codec:h264' --cookies ~/ytdlwl/cookies/cookies.txt --paths $OUTPUT_PATH https://www.youtube.com/playlist?list=WL 

echo adjusting file dates...
python3 set_file_date.py ${OUTPUT_PATH} ${OUTPUT_PATH}/playlist.json
