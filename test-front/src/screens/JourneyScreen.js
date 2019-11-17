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
import MultiSelect from 'react-native-multiple-select';

const items = [{
  id: '1',
  name: 'Aggressive'
}, {
  id: '2',
  name: 'Easy Going'
}, {
  id: '3',
  name: 'Happy'
}, {
  id: '4',
  name: 'Romantic'
}, {
  id: '5',
  name: 'Sad'
}, {
  id: '6',
  name: 'Sentimental'
}, {
  id: '7',
  name: 'Suspenseful'
}, {
  id: '8',
  name: 'Uplifting'
}, {
  id: '9',
  name: 'Calm'
}, {
  id: '10',
  name: 'Groovy'
}, {
  id: '11',
  name: 'Laid Back'
}, {
  id: '12',
  name: 'Powerful'
}]

const items2 = [{
  id: '1',
  name: '1'
}, {
  id: '2',
  name: '2'
}, {
  id: '3',
  name: '3'
}, {
  id: '4',
  name: '4'
}, {
  id: '5',
  name: '5'
}, {
  id: '6',
  name: '6'
}, {
  id: '7',
  name: '7'
}, {
  id: '8',
  name: '8'
}, {
  id: '9',
  name: '9'
}, {
  id: '10',
  name: '10'
}, {
  id: '11',
  name: '11'
}, {
  id: '12',
  name: '12'
}]


class screen extends React.Component {
  state = {
    selectedItems: [],
    selectedItems2: []
  }

  onSelectedItemsChange = (selectedItems) => {
    this.setState({ selectedItems }, () => console.warn('Selected Items: ', selectedItems))
  }
  onSelectedItems2Change = (selectedItems2) => {
    this.setState({ selectedItems2 }, () => console.warn('Selected Items 2: ', selectedItems2))
  }

  render() {
    const { selectedItems, selectedItems2 } = this.state;

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
        <MultiSelect
            items={items2}
            uniqueKey='id'
            onSelectedItemsChange={this.onSelectedItemsChange}
            selectedItems={selectedItems}
            selectText='Select the mood!'
            searchInputPlaceholderText='Search Items...'
            tagRemoveIconColor='#CCC'
            tagBorderColor='#CCC'
            tagTextColor='#CCC'
            selectedItemTextColor='#CCC'
            selectedItemIconColor='#CCC'
            itemTextColor='#000'
            displayKey='name'
            searchInputStyle={{ color: '#CCC' }}
            submitButtonColor='#CCC'
            submitButtonText='Submit'
            removeSelected
          />
          <MultiSelect
            items={items}
            uniqueKey='id'
            onSelectedItemsChange={this.onSelectedItems2Change}
            selectedItems={selectedItems2}
            selectText='Select the mood!'
            searchInputPlaceholderText='Search Items...'
            tagRemoveIconColor='#CCC'
            tagBorderColor='#CCC'
            tagTextColor='#CCC'
            selectedItemTextColor='#CCC'
            selectedItemIconColor='#CCC'
            itemTextColor='#000'
            displayKey='name'
            searchInputStyle={{ color: '#CCC' }}
            submitButtonColor='#CCC'
            submitButtonText='Submit'
            removeSelected
          />
</View>
    );
  }
}

export default function PlayerScreen() {
  return new screen;
}
