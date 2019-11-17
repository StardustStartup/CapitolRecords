import m3u8
import requests
import json
import os

track = "USWWW0128853"

base_url = "https://hackathon.umusic.com/prod/v1"
headers = {"x-api-key": os.environ.get("UMG_KEY")}

track_url = base_url + '/isrc/' + track + '/stream.m3u8'

response = requests.get(track_url, headers=headers)

file = open("resp_text.m3u8", "w")
file.write(response.text)
file.close()

m3u8_obj = m3u8.load("./resp_text.m3u8")  # this could also be an absolute filename
print(m3u8_obj.segments)
print(m3u8_obj.target_duration)

# if you already have the content as string, use

m3u8_obj = m3u8.loads('#EXTM3U8')