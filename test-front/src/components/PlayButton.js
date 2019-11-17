import React, { Component } from "react";
import { StyleSheet, View, Image } from "react-native";

function PlayButton(props) {
  return (
    <View style={[styles.container, props.style]}>
      <Image
        source={require("../assets/images/Eminem_Rap_God.png")}
        resizeMode="contain"
        style={styles.image}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {},
  image: {
    width: 200,
    height: 200
  }
});

export default PlayButton;
