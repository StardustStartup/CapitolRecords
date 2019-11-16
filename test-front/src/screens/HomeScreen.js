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
      <View style={styles.container}>
        <ScrollView
          style={styles.container}
          contentContainerStyle={styles.contentContainer}>
          <View style={styles.welcomeContainer}>
            <Image
              source={
                __DEV__
                  ? require('../../assets/logo1.jpg')
                  : require('../../assets/logo1.jpg')
              }
              style={styles.welcomeImage}
            />
          </View>
          <View style={styles.getStartedContainer}>

            <Text h4>{"\n"}Welcome to Stardust!{"\n"}</Text>
            <Text>Let's go on a...{"\n"}{"\n"}</Text>
          </View>
          <View style={styles.fixToText}>
            <Button
              title="Roadtrip"
              type="outline"
              raised="True"
              onPress={() => navigate('Player')}
            />
            <Button
              title="Journey"
              type="outline"
              raised="True"
              onPress={() => navigate('Journey')}
            />
          </View>
          <Text>{'\n'}{'\n'}</Text>
          <View style={styles.fixToText}>
          <Text>testing what {'\n'}happens if {'\n'}i write a {'\n'}bunch of {'\n'}text here</Text>
          <Text>                                       changing the type of                                        text im suing here</Text>
          </View>
      </ScrollView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 50,
    backgroundColor: '#fff',
  },
  developmentModeText: {
    marginBottom: 20,
    color: 'rgba(0,0,0,0.4)',
    fontSize: 14,
    lineHeight: 19,
    textAlign: 'center',
  },
  contentContainer: {
    paddingTop: 30,
  },
  container3: {
    flex: 3,
  },
  welcomeContainer: {
    alignItems: 'center',
    marginTop: 10,
    marginBottom: 20,
  },
  welcomeImage: {
    width: 100,
    height: 80,
    resizeMode: 'contain',
    marginTop: 3,
    marginLeft: -10,
  },
  getStartedContainer: {
    alignItems: 'center',
    marginHorizontal: 50,
    flex: 2,
  },
  homeScreenFilename: {
    marginVertical: 7,
  },
  codeHighlightText: {
    color: 'rgba(96,100,109, 0.8)',
  },
  codeHighlightContainer: {
    backgroundColor: 'rgba(0,0,0,0.05)',
    borderRadius: 3,
    paddingHorizontal: 4,
  },
  getStartedText: {
    fontSize: 17,
    color: 'rgba(96,100,109, 1)',
    lineHeight: 24,
    textAlign: 'center',
  },
  tabBarInfoContainer: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    ...Platform.select({
      ios: {
        shadowColor: 'black',
        shadowOffset: { width: 0, height: -3 },
        shadowOpacity: 0.1,
        shadowRadius: 3,
      },
      android: {
        elevation: 20,
      },
    }),
    alignItems: 'center',
    backgroundColor: '#fbfbfb',
    paddingVertical: 20,
  },
  tabBarInfoText: {
    fontSize: 17,
    color: 'rgba(96,100,109, 1)',
    textAlign: 'center',
  },
  navigationFilename: {
    marginTop: 5,
  },
  helpContainer: {
    marginTop: 15,
    alignItems: 'center',
  },
  helpLink: {
    paddingVertical: 15,
  },
  helpLinkText: {
    fontSize: 14,
    color: '#2e78b7',
  },
  fixToText: {
    marginLeft: 50,
    marginRight: 50,
  flexDirection: 'row',
  justifyContent: 'space-between',
},


});

export default function HomeScreen() {
  return new screen;
}
