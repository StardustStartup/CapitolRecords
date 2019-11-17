import React, { Component } from "react";
import { StyleSheet, View, Text } from "react-native";
import MaterialButtonViolet from "../components/MaterialButtonViolet";
import PlayButton from "../components/PlayButton";
import MaterialButtonShare1 from "../components/MaterialButtonShare1";
import MaterialIconButtonsFooter from "../components/MaterialIconButtonsFooter";

function Player() {
  return (
    <View style={styles.container}>
      <View style={styles.materialButtonVioletStack}>
        <MaterialButtonViolet style={styles.materialButtonViolet} />
        <MaterialButtonViolet style={styles.materialButtonViolet2} />
      </View>
      <Text style={styles.rapGodEminem}>Rap God{"\n"}Eminem</Text>
      <PlayButton style={styles.albumCover} />
      <MaterialButtonShare1 style={styles.pausePlay} />
      <MaterialIconButtonsFooter style={styles.materialIconButtonsFooter} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  materialButtonViolet: {
    top: 0,
    left: 0,
    width: 100,
    height: 36,
    position: "absolute"
  },
  materialButtonViolet2: {
    top: 0,
    left: 0,
    width: 100,
    height: 36,
    position: "absolute"
  },
  materialButtonVioletStack: {
    width: 100,
    height: 36,
    marginTop: 60,
    marginLeft: 18
  },
  rapGodEminem: {
    color: "#121212",
    fontSize: 24,
    fontFamily: "roboto-regular",
    textAlign: "center",
    marginTop: 139,
    alignSelf: "center"
  },
  albumCover: {
    width: 200,
    height: 200,
    marginTop: 23,
    alignSelf: "center"
  },
  pausePlay: {
    width: 56,
    height: 56,
    marginTop: 46,
    alignSelf: "center"
  },
  materialIconButtonsFooter: {
    width: 375,
    height: 56,
    marginTop: 148
  }
});

export default Player;
