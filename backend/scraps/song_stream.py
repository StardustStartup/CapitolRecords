import requests
import json
import os


def getSongAPI(songName, artist):
  #curl -X GET 'https://hackathon.umusic.com/prod/v1/search/artists?q=elvis' -H 'x-api-key: YOUR_TOKEN'
  pass

def getSongStream(songName, artist):  
  pass

def getSongMeta(songName, artist):
  pass

def tester(priorSongFact, nextSongName, nextArtist, nextArtistFact, outFile):



  url = "https://hackathon.umusic.com/prod/v1/search/artists?q=" + nextArtist.replace(" ", "+") + "+" + nextSongName.replace(" ", "+")
  authenticator = IAMAuthenticator(os.environ.get("WATSON_KEY"))
  text_to_speech = TextToSpeechV1(
      authenticator=authenticator
  )

  with open(outFile, 'wb') as audio_file:
      audio_file.write(
          text_to_speech.synthesize(
              compiledText,
              voice='en-US_MichaelV3Voice',
              accept='audio/wav'        
          ).get_result().content)


#createRadio("beep is a big fookin chungis bigga ligga tigga bit.", "bruh", "boop", "skraa", "bruh.wav")

artist = "Eminem"
songName = "Rap God"
print(strr)
print(strr.replace(" ", "+"))
