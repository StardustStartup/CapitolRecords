import os
import csv
import requests
import json

# Boilerplate script which will eventually query all artists

endpoint = "https://hackathon.umusic.com/prod/v1/artists"
api_key = os.environ.get('MUSICBRAINZ_API_KEY')

response = requests.get(
    endpoint,
    params={},
    headers={'x-api-key': api_key},
)

json_response = response.json()