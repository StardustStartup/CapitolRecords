import React from 'react';
import { Platform } from 'react-native';
import { createStackNavigator, createBottomTabNavigator } from 'react-navigation';
import RoadScreen from '../screens/Roadtrip';

const config = Platform.select({
  web: { headerMode: 'screen' },
  default: {},
});

const RoadStack = createStackNavigator(
  {
    Road: RoadScreen,
  },
  config
);

RoadStack.navigationOptions = {
  tabBarLabel: 'Road',
  tabBarIcon: ({ focused }) => (
    <TabBarIcon
      focused={focused}
      name={
        Platform.OS === 'ios'
          ? `ios-information-circle${focused ? '' : '-outline'}`
          : 'md-information-circle'
      }
    />
  ),
};

RoadStack.path = '';

export default RoadStack;
