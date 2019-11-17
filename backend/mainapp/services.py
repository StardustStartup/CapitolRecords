import requests
import json
import os
from bs4 import BeautifulSoup

base_url = 'https://api.genius.com'
headers = {'Authorization': 'Bearer ' + os.environ.get("GENIUS_KEY")}

def request_song_info(song_title, artist_name):
    search_url = base_url + '/search'
    data = {'q': song_title + ' ' + artist_name}
    response = requests.get(search_url, data=data, headers=headers)
    return response

def lyrics_from_song_api_path(song_api_path):
  song_url = base_url + song_api_path
  response = requests.get(song_url, headers=headers)
  myjson = response.json()
  path = myjson["response"]["song"]["path"]
  #gotta go regular html scraping... come on Genius
  page_url = "http://genius.com" + path
  page = requests.get(page_url)
  html = BeautifulSoup(page.text, "html.parser")
  #remove script tags that they put in the middle of the lyrics
  [h.extract() for h in html('script')]
  #at least Genius is nice and has a tag called 'lyrics'!
  lyrics = html.find("div", class_="lyrics").get_text() #updated css where the lyrics are based in HTML
  return lyrics

def getSongLyric(song_title, artist_name):
  response = request_song_info(song_title, artist_name)
  myjson = response.json()
  remote_song_path = None

  for hit in myjson['response']['hits']:
      if artist_name.lower() in hit['result']['primary_artist']['name'].lower():
          remote_song_path = hit['result']['api_path']
          break
  
  lyrics = lyrics_from_song_api_path(remote_song_path)
  print(lyrics)
  return lyrics

###### This is the one we care about
def fact_from_song_api_path(song_api_path):
  song_url = base_url + song_api_path
  response = requests.get(song_url, headers=headers)
  myjson = response.json()
  path = myjson["response"]["song"]["path"]
  #gotta go regular html scraping... come on Genius
  page_url = "http://genius.com" + path
  page = requests.get(page_url)
  html = BeautifulSoup(page.text, "html.parser")
  #remove script tags that they put in the middle of the lyrics
  [h.extract() for h in html('script')]

  #at least Genius is nice and has a tag called 'lyrics'!
  fact = html.find("div", class_="rich_text_formatting").get_text() #updated css where the lyrics are based in HTML
  return fact

def getSongFact(song_title, artist_name):
  response = request_song_info(song_title, artist_name)
  myjson = response.json()
  remote_song_path = None

  for hit in myjson['response']['hits']:
      if artist_name.lower() in hit['result']['primary_artist']['name'].lower():
          remote_song_path = hit['result']['api_path']
          break
  
  fact = fact_from_song_api_path(remote_song_path)
  # print(fact)
  # return fact
  data = {}
  data['result'] = fact
  json_data = json.dumps(data)
  return json_data
