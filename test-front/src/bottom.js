import React, {Component} from 'react';
import { createAppContainer, createSwitchNavigator } from 'react-navigation';
import { createStackNavigator } from 'react-navigation-stack';

import {
  Image,
  Platform,
  AppRegistry,
  StyleSheet,
  View,
  Alert
} from 'react-native';

import { Button, Text } from 'react-native-elements';

import HomeScreen from './screens/HomeScreen';
import TripScreen from './screens/TripScreen';
import JourneyScreen from './screens/JourneyScreen';
import PlayerScreen from './screens/PlayerScreen';


const HomeStack = createStackNavigator(
  {
    HomeScreen: {
      screen: HomeScreen,
      navigationOptions: () => ({
        title: "Home",
      }),
    },
  },
  {
    initialRouteName: 'HomeScreen',
  },
);

const TripStack = createStackNavigator(
  {
    TripScreen: {
      screen: TripScreen,
      navigationOptions: () => ({
        title: "Trip",
      }),
    },
  },
  {
    initialRouteName: 'TripScreen',
  },
);

const JourneyStack = createStackNavigator(
  {
    JourneyScreen: {
      screen: JourneyScreen,
      navigationOptions: () => ({
        title: "Journey",
      }),
    },
  },
  {
    initialRouteName: 'JourneyScreen',
  },
);

const PlayerStack = createStackNavigator(
  {
    PlayerScreen: {
      screen: PlayerScreen,
      navigationOptions: () => ({
        title: "Player",
      }),
    },
  },
  {
    initialRouteName: 'PlayerScreen',
  },
);


const App = createAppContainer(
  createBottomTabNavigator(
    {
      Home: HomeStack,
      Trip: TripStack,
      Journey: JourneyStack,
      Player: PlayerStack,
    },
    {
      initialRouteName: 'Home',
    },
  ),
);


export default Bottom;
