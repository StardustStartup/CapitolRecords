import React, {Component} from 'react';
import Player from 'react-native-streaming-audio-player';
import {
  Image,
  ScrollView,
  Platform,
  AppRegistry,
  Button,
  StyleSheet,
  View,
  Alert
} from 'react-native';
/*import { Button, Text } from 'react-native-elements';


class screen extends React.Component {
  render() {
    const {navigate} = this.props.navigation;
    return (
      <Button
        title="Go to Home"
        onPress={() => navigate('Home')}
      />
    );
  }
}*/

class Example extends Component {
  constructor(props) {
    super(props);
    this.state = { currentTime: 0 }
    this.onUpdatePosition = this.onUpdatePosition.bind(this);
  }
 
  onPlay() {
    Player.play(source.url, {
      title: source,
      artist: source.artist,
      album_art_uri: source.arworkUrl,
    });
  }
 
  onPause() {
    Player.pause();
  }
 
  render() {
    return (
      <View style={styles.container}>
        <View style={{ flexDirection: 'row', alignSelf: 'stretch', justifyContent: 'space-around' }}>
          <Button
            title='Play'
            onPress={() => this.onPlay()}
            color='red'
          />
          <Button
            title='Pause'
            onPress={() => this.onPause()}
            color='red'
          />
        </View>
      </View>
    );
  }
}
 
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});


export default function HomeScreen() {
  return new Example;
}