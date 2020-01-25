# CapitolRecords

## Inspiration
Radio stations these days are filled with repeated music and irrelevant chatter from the radio hosts. The original point of radio stations were so that people felt as though they weren't alone on trips. With Stardust, you can say goodbye to radio hosts that won't stop talking about themselves, and start listening to perfectly curated music while booking concert tickets, finding new artists, and learning about music history, all activated through your voice.

## What it does
Stardust has multiple layers. At the most basic layer, it is a music service, similar to Spotify or Pandora, that utilizes machine learning to play new songs that you might be interested in. With Ford's Audio Passthrough technology, IBM Watson listens to your reaction after the song and uses sentiment analysis in the music curation algorithm to generate new content from the UMG song database. Additionally, our algorithm tracks your current location and plays songs from artists native to cities near you.

Additionally, we incorporated several other APIs to make the discovery and convenience components as smooth as possible. You can book tickets for concerts (Ticketmaster API) and parking for your car (Arrive API) just by speaking to your car! We read in the final destination of your trip (SDL) and search for events.

To establish a baseline for our algorithm, we request the user to input current mood and favorite genre at the beginning of the trip.

## How we built it
The back-end was completed in Django. The front end was the real tricky portion. We have 3 different front-ends.

* First, we have a client interface which was completed in React-Native. This is how we send user data regarding mood/genre to the back-end.
* Second, we have a connection interface to link the user's phone and SDL. This was accomplished with a native IOS Swift application.
* Third, inside the Swift application, through the ConnectedTravel framework we incorporated a front-end for the SDL display itself, which includes buttons for parking/events and a media player for the song.

## Challenges we ran into
We were unable to incorporate a native Swift program into React-Native which is what required us to make a booster application and separate the two front-ends. This proved fairly difficult as neither of us had ever developed for mobile before. Another significant challenge was incorporating the UMG audio files. The files were in a .m3u8 format which also required an API key in the header. This is fairly simple to execute in a command prompt, but both incorporating that in native Swift and including the header was incredibly difficult as the extraction process to stream a .m3u8 file is most certainly non-trivial.

## Accomplishments that we're proud of
We're proud of many things! Most importantly we got a legitimate application working by the end of the hackathon. As computer engineers that have never developed in mobile before, we were super happy to be able to complete what we set out to accomplish, and compete against some incredible developers in the community. We are also proud of the fact that we completed this hackathon as juniors in undergrad, when the large majority of competitors were industry professionals with experience with these technologies. This was also an incredible opportunity for us to learn and we most certainly took advantage of the great minds around us to soak knowledge and connect for future work.

## What we learned
We learned how to develop mobile apps, and a LOT about the music industry!

## What's next for Stardust
Stay tuned! We are incredibly grateful and thrilled to have won the Grand Prize of $12,000 and will continue to build our application with the folks from Ford/SDL/ConnectedTravel.
