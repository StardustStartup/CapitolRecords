import requests
import json
import os

base_url = 'https://hackathon.umusic.com/prod/v1'
headers = {"x-api-key": os.environ.get("UMG_KEY")}

def request_artist(artist):72
  search_url = base_url + '/search/artists'
  data = {'q': artist_name}
  response = requests.get(search_url, data=data, headers=headers)

  return response


def api_call(artist, song):
  response = request_artist(artist)


#createRadio("beep is a big fookin chungis bigga ligga tigga bit.", "bruh", "boop", "skraa", "bruh.wav")

artist = "Eminem"
songName = "Rap God"
print(request_artist(artist).json())
