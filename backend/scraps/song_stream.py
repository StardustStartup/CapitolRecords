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

def get_song_hit(artist_id,hit):
  artists_url = base_url + '/artists/' + str(artist_id)
  response = requests.get(artists_url, headers=headers).json()['artist']['tracks'][hit]['title']
  return response

def request_song_isrc(artist_id,song_name):
  artists_url = base_url + '/artists/' + str(artist_id)
  response = requests.get(artists_url, headers=headers).json()['artist']['tracks']
  song_find = response[0]['title']
  song_index = 0

  while(song_find != song_name):
    song_index = song_index + 1
    song_find = response[song_index]['title']
  
  return response[song_index]['isrc']


def request_stream(track):
  track_url = base_url + '/isrc/' + track + '/stream.m3u8'
  response = requests.get(track_url, headers=headers)

  return track_url

def request_url(artist,song):
  artist_id = get_artist_id(artist)
  song_isrc = request_song_isrc(artist_id,song)
  stream = request_stream(song_isrc)
  return stream

def load_file(artist,song):
  url = request_url(artist,song)
  content = (requests.get(url, headers=headers)).text
  return(content)
  #filename = song + ".m3u8"
  #file = open(filename, "w")
  #file.write(content)
  #file.close()

artist1 = "Jeremy Zucker"
song1 = "History (Of The World) (Part 2)"
artist_id1 = get_artist_id(artist1)
print(artist_id1)
print(get_song_hit(artist_id1,0))

artist2 = "The Doors"
song2 = "Away From The Sun"
artist_id2 = get_artist_id(artist2)
print(artist_id2)
print(get_song_hit(artist_id2,0))
#load_file(artist,song)

print(request_url(artist1,song1))
print(request_url(artist2,song2))

#https://hackathon.umusic.com/prod/v1/isrc/DEF069011180/stream.m3u8
#https://hackathon.umusic.com/prod/v1/isrc/USUG10701458/stream.m3u8
#print(request_stream(track))

