import React, {Component} from 'react';
import { StyleSheet, View, Button } from 'react-native';
import { createAppContainer, createSwitchNavigator } from 'react-navigation';
import { createStackNavigator } from 'react-navigation-stack';
import Player from 'react-native-streaming-audio-player';
import PlayerScreen from './screens/PlayerScreen';



const PlayerStack = createStackNavigator(
  {
    PlayerScreen: {
      screen: PlayerScreen,
      navigationOptions: () => ({
        //title: "Player",
      }),
    },
  },
  {
    initialRouteName: 'PlayerScreen',
  },
);


const App = createAppContainer(
  createSwitchNavigator(
    {
      Player: PlayerStack,
    },
    {
      initialRouteName: 'Player',
    },
  ),
);

export default App;