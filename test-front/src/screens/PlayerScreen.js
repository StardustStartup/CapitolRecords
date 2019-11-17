import React, {Component} from 'react';
import {
  Image,
  ScrollView,
  Platform,
  AppRegistry,
  StyleSheet,
  View,
  Alert
} from 'react-native';
import { Button, Text } from 'react-native-elements';
import MaterialIconButtonsFooter from "../components/MaterialIconButtonsFooter";
import { Audio } from 'expo-av';

source = {
  uri: 'https://hackathon.umusic.com/prod/v1/isrc/USWWW0128853/stream.m3u8',
  headers: {'x-api-key': 'xmN6Ijjcxy1GzOGsOcu1a6EpbSden1c64P3r5bQh'}
}


async function onPlay() {
  const soundObject = new Audio.Sound();
  //soundObject.setOnPlaybackStatusUpdate(onPlaybackStatusUpdate);
  await soundObject.loadAsync(source, initialStatus = {}, downloadFirst = true);
  await soundObject.playAsync();
  //Audio.Sound.createAsync(source, initialStatus = {}, onPlaybackStatusUpdate = null, downloadFirst = true);
  
}


class screen extends React.Component {

  render() {
    
    const {navigate} = this.props.navigation;
   
    return (
    <View style={{flex: 1, padding: 20}}>
      <View style={{width: 100}}>
        <Button
          title="Go back"
          onPress={() => navigate('Journey')}
        />
      </View>

      <View style={{width: 50, paddingTop: 50}}>
        <Button
          title="PLAY"
          onPress={() => onPlay()}
        />
      </View>
      
      <View style={{position: 'absolute', left: 0, right: 0, bottom: 0}}>
        <MaterialIconButtonsFooter style={styles.materialIconButtonsFooter} />
      </View>
    </View>
    );
  }
}

export default function HomeScreen() {
  return new screen;
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  materialIconButtonsFooter: {
    position: 'absolute',
    left: 0,
    right: 0,
    bottom: 0
  }
});