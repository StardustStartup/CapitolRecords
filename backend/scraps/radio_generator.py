# import requests
# import json
import os
from ibm_watson import TextToSpeechV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator

def getSongFact(songName, songArtist):
  pass

def getArtistFact(songName, artist, arg, mylist):
  
  pass

def createRadio(priorSongFact, nextSongName, nextArtist, nextArtistFact, outFile):

  compiledText = priorSongFact + " Next up is " + nextSongName + " by " + nextArtist + ". " + nextArtistFact
  
  authenticator = IAMAuthenticator(os.environ.get("WATSON_KEY"))
  text_to_speech = TextToSpeechV1(
      authenticator=authenticator
  )

  text_to_speech.set_service_url('https://stream.watsonplatform.net/text-to-speech/api')

  with open(outFile, 'wb') as audio_file:
      audio_file.write(
          text_to_speech.synthesize(
              compiledText,
              voice='en-US_MichaelV3Voice',
              accept='audio/wav'        
          ).get_result().content)

createRadio("beep is a big fookin chungis bigga ligga tigga bit.", "bruh", "boop", "skraa", "bruh.wav")

