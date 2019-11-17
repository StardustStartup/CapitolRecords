import requests
import json
import os

base_url = "https://hackathon.umusic.com/prod/v1"
headers = {"x-api-key": os.environ.get("UMG_KEY")}

def request_artist(artist):
  search_url = base_url + '/search/artists?q=' + artist
  #data = {'q': artist}
  response = requests.get(search_url, headers=headers)

  return response


def get_artist_id(artist):
  response = request_artist(artist).json()
  artist_id = response['artists'][0]['artist_id']
  return artist_id


def request_meta(track):
  track_url = base_url + '/tracks/' + track
  response = requests.get(track_url, headers=headers)

  return response

def request_stream(track):
  track_url = base_url + '/isrc/' + track + '/stream.m3u8'
  response = requests.get(track_url, headers=headers)

  return response



artist = "Eminem"
songName = "Rap God"
track = "USWWW0128853"
#print(get_artist_id(artist))
print(request_stream(track))

