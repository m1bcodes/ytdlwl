# Installation

1. install venv:
Adapt the  version number to your python version accordingly
```
sudo apt-get install ffmpeg
sudo apt install python3.9-venv
python3 -m venv ytdlwl
source ytdlwl/bin/activate
./install-yt-dlp.sh
```

2. setup cron job
```
crontab -e
```
Add the following line to start the update daily at 3:00 am
```
0 3 * * * /usr/bin/flock -w 0 ~/ytdlwl/update_wl.lock ~/ytdlwl/update_wl.sh > ~/ytdlwl/update_wl.log 2>&1
```

flock prevents overlapping runs. For a daily job it might not be necessary, but it is also useful for testing purposes (just write * * * * *, so start it once a minute).

# Update cookies
The yt-dlp logsin to youtube using cookies:
1. Start firefox and install addon "export cookies"
2. login to youtube and select the channel to access
3. Export cookies (of all sites, just to be sure).
4. Save as ~/ytdlwl/cookies/cookies.txt
