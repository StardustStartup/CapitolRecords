from django.shortcuts import render
from .models import Artist, Song, Concert
from .serializers import ArtistSerializer, SongSerializer, ConcertSerializer
from rest_framework.generics import ListCreateAPIView,RetrieveUpdateDestroyAPIView
from django.views.generic.base import TemplateView
from mainapp import services
from django.http import HttpResponse

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

class GeniusWrapper(TemplateView):
    def get(self, request):
        output = services.getSongFact("Rap God", "Eminem")
        return HttpResponse(output, content_type='application/json')
