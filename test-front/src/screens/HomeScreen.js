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


class screen extends React.Component {
  render() {
    const {navigate} = this.props.navigation;
    return (
      <Button
        title="Go to Trip"
        onPress={() => navigate('Trip')}
      />
    );
  }
}

export default function HomeScreen() {
  return new screen;
}