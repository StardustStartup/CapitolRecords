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
  name: 'Alternative Pop'
}, {
  id: '2',
  name: 'Alternative Rock'
}, {
  id: '3',
  name: 'Blues'
}, {
  id: '4',
  name: 'Brazilian'
}, {
  id: '5',
  name: 'Classic Pop'
}, {
  id: '6',
  name: 'Classic Rock'
}, {
  id: '7',
  name: 'Classical'
}, {
  id: '8',
  name: 'Country'
}, {
  id: '9',
  name: 'Dance'
}, {
  id: '10',
  name: 'Electronic'
}, {
  id: '11',
  name: 'Folk'
}, {
  id: '12',
  name: 'Gospel'
}, {
  id: '13',
  name: 'Hip Hop'
}, {
  id: '14',
  name: 'Jazz'
}, {
  id: '15',
  name: 'Latin'
}, {
  id: '16',
  name: 'Metal'
}, {
  id: '17',
  name: 'Modern Pop'
}, {
  id: '18',
  name: 'Pop Rock'
}, {
  id: '19',
  name: 'Reggae'
}, {
  id: '20',
  name: 'R&B'
}, {
  id: '21',
  name: 'Spoken'
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


    const {navigate} = this.props.navigation;
    return (
      <View
        style={{
          padding: 20,
        }}>
                    <Text>{'\n'}</Text>
        <MultiSelect
            items={items2}
            uniqueKey='id'
            onSelectedItemsChange={this.onSelectedItemsChange}
            selectedItems={selectedItems}
            selectText='Choose a Genre!'
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
                    <Text>{'\n'}</Text>

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
          <Text>{'\n'}{'\n'}</Text>

<Button
              title="Submit"
              type="outline"
              raised="True"
              onPress={() => navigate('Player')}
            />
</View>
    );
  }
}

export default function PlayerScreen() {
  return new screen;
}
