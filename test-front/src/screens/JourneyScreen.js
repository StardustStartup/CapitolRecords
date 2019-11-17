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
import { Button, Text, ListItem, TouchableScale, LinearGradient } from 'react-native-elements';



class screen extends React.Component {
  render() {

    const list = [
      {
        title: 'Appointments',
        icon: 'av-timer'
      },
      {
        title: 'Trips',
        icon: 'flight-takeoff'
      },
    ]


    const {navigate} = this.props.navigation;
    return (
      <View>
      <Button
        title="Go to Player"
        onPress={() => navigate('Player')}
      />
      {
          list.map((item, i) => (
            <ListItem
              key={i}
              title={item.title}
              leftIcon={{ name: item.icon }}
              bottomDivider
              chevron
              onPress={() => navigate('Player', {name: 'Jane'})}
            />
          ))
        }

</View>
    );
  }
}

export default function PlayerScreen() {
  return new screen;
}
