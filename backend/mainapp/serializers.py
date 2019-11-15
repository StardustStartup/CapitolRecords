from rest_framework import serializers
from . import models

class ArtistSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Artist
        fields = ('id', 'name', 'genre', 'location',)
    
class SongSerializer(serializers.ModelSerializer):
    artists = serializers.PrimaryKeyRelatedField(
        many=True,
        queryset=models.Artist.objects.all() 
    )
    class Meta:
        model = models.Song
        fields = ('id', 'name', 'artists', 'genre',)

class ConcertSerializer(serializers.ModelSerializer):
    artists = serializers.PrimaryKeyRelatedField(
        many=True,
        queryset=models.Artist.objects.all() 
    )
    class Meta:
        model = models.Concert
        fields = (
            'id',
            'artists',
            'genre',
            'min_price',
            'bit_link',
            'tm_link',
            'location',
            'date',
            'pref_link',
        )
