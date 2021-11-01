"""
loads a json representation of a playlist as it was returned by yt-dlp -J.
For all files in <folder> which have an id (in square brackets) in the filename,
file modification and access time is set to the video upload date.
"""

import sys
import json
from pprint import pprint
import os
import re
from datetime import datetime

if len(sys.argv) != 3:
    raise ValueError('usage: set_file_date <folder> <playlist-json-file>') 

folder = sys.argv[1]
jsonfile = sys.argv[2]

with open(jsonfile) as f:
    d = json.load(f)

entries = d["entries"]
ids = {}
for entry in entries:
	try:
		id = entry["id"]
		print("id=" + id)
		print("upload_date=" + str(entry["upload_date"]))
		ids[id] = datetime.strptime(entry["upload_date"],"%Y%m%d")
	except:
		print("failed to get datetime")
		
# pprint(d)
print(ids)

files = os.listdir(folder)
for file in files:
    print(file)
    m = re.match(".*\[([a-zA-Z0-9_\-]+)\].*", file)
    if m is not None:
        fileId = m[1]
        print(fileId)
        fullpath = os.path.join(folder, file)
        if  fileId in ids.keys():
            dt = ids[fileId]
            print("change time to " + str(dt))
            os.utime(fullpath, (dt.timestamp(), dt.timestamp()))

