from django.shortcuts import render
from .models import Artist, Song, Concert
from .serializers import ArtistSerializer, SongSerializer, ConcertSerializer
from rest_framework.generics import ListCreateAPIView,RetrieveUpdateDestroyAPIView

# Create your views here.
class ArtistList(ListCreateAPIView):
    queryset = Artist.objects.all().order_by('name')
    serializer_class = ArtistSerializer

class ArtistDetail(RetrieveUpdateDestroyAPIView):
    queryset = Artist.objects.all()
    serializer_class = ArtistSerializer

class SongList(ListCreateAPIView):
    queryset = Song.objects.all().order_by('name')
    serializer_class = SongSerializer

class SongDetail(RetrieveUpdateDestroyAPIView):
    queryset = Song.objects.all()
    serializer_class = SongSerializer

class ConcertList(ListCreateAPIView):
    queryset = Concert.objects.all().order_by('date')
    serializer_class = ConcertSerializer

class ConcertDetail(RetrieveUpdateDestroyAPIView):
    queryset = Concert.objects.all()
    serializer_class = ConcertSerializer
