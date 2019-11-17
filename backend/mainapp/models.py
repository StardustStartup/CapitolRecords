from django.contrib.gis.db import models

# Create your models here.
class Artist(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    genre = models.CharField(max_length=100)
    location = models.PointField()

class Song(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=250)
    artists = models.ManyToManyField(Artist)
    genre = models.CharField(max_length=100)

class Concert(models.Model):
    id = models.AutoField(primary_key=True)
    artists = models.ManyToManyField(Artist)
    genre = models.CharField(max_length=100)
    min_price = models.DecimalField(decimal_places=2, max_digits=6)
    bit_link = models.URLField()
    tm_link = models.URLField()
    location = models.PointField()
    date = models.DateTimeField()
    pref_link = models.IntegerField()

class FSM(models.Model):
    id = models.AutoField(primary_key=True)
    genre = models.CharField(max_length=100)
    mood = models.CharField(max_length=100)
    location = models.CharField(max_length=100)
    current_song = models.CharField(max_length=100)