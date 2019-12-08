# import requests
# import json
import os
from ibm_watson import TextToSpeechV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator

def getSongFact(songName, songArtist):
  pass

def getArtistFact(songName, artist, arg, mylist):
  
  pass

def createRadio(outFile1):

  #compiledText = priorSongFact + " Next up is " + nextSongName + " by " + nextArtist + ". " + nextArtistFact
  compiledText1 = "Axonal fibers from neurons in the vestibular ganglion (Scarpa’s ganglion) enter the CNS and course medial to the cochlear nuclei and inferior cerebellar peduncle. They terminate in the four major subdivisions of the vestibular nucleus (VN): inferior, superior, medial and lateral and to the cerebellum. The four subdivisions of the vestibular nucleus extent over a relatively long distance on the dorsal surface of the medulla and pons. Any lesion that affects the dorsal surface of the pons and medulla is likely to impact the vestibular system. In addition to its projections to the vestibular nucleus, the vestibular labyrinth is the only sensory organ that sends direct primary afferent projections to the cerebellum. Indeed, axons from vestibular ganglion neurons send axonal projections to the cerebellum via the juxtarestiform body, a subdivision of the inferior cerebellar peduncle. They terminate in a region of the cerebellum called the vestibular cerebellum, which includes the flocculus, the nodulus, the uvula and the fastigial nucleus. The major central projections from the vestibular nuclei are to the spinal cord, the cerebellum and oculomotor nuclei. Neurons in vestibular nuclei also send axons to the thalamus and to brainstem nuclei other than oculomotor nuclei. The anatomical and functional organization of vestibular projections to the thalamus and, by way of the thalamus, to the cerebral cortex is poorly understood."
  compiledText2 = "How did you like that song?"
  compiledText3 = "Great! The Doors were an American rock band formed in Los Angeles in 1965! They wrote rock and pop music. Nice purchase! Jeremy Zucker is a New Jersey native singer, songwriter, and producer inspired by the likes of Jon Bellion and Bon Iver. Here’s History of the World Part 2 by him. Remember, you can always turn me off in the settings!"
  authenticator = IAMAuthenticator(os.environ.get("WATSON_KEY"))
  text_to_speech = TextToSpeechV1(
      authenticator=authenticator
  )

  text_to_speech.set_service_url('https://stream.watsonplatform.net/text-to-speech/api')

  with open(outFile1, 'wb') as audio_file:
      audio_file.write(
          text_to_speech.synthesize(
              compiledText1,
              voice='en-US_MichaelV3Voice',
              accept='audio/mp3'        
          ).get_result().content)

createRadio('brain.mp3')