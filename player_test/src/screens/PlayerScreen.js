import React, {Component} from 'react';
//import Player from 'react-native-streaming-audio-player';
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
//import { Button, Text } from 'react-native-elements';


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
}
 
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});


export default function HomeScreen() {
  return new screen;
}