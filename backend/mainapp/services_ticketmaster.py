import requests
import json
import os

base_url = "https://app.ticketmaster.com/discovery/v2/events/"
apikey = os.environ.get("TICKETMASTER_KEY")

size = "&size=1"


def getLocalConcerts(lat, long):
    pass