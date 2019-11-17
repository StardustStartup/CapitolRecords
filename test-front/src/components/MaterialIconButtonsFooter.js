import React, { Component } from "react";
import { StyleSheet, View, TouchableOpacity } from "react-native";
import MaterialCommunityIconsIcon from "react-native-vector-icons/MaterialCommunityIcons";

function MaterialIconButtonsFooter(props) {
  return (
    <View style={[styles.container, props.style]}>
      <TouchableOpacity style={styles.buttonWrapper1}>
        <MaterialCommunityIconsIcon name="television" style={styles.icon1} />
      </TouchableOpacity>
      <TouchableOpacity style={styles.buttonWrapper2}>
        <MaterialCommunityIconsIcon
          name="music-note"
          style={styles.activeIcon}
        />
      </TouchableOpacity>
      <TouchableOpacity style={styles.buttonWrapper3}>
        <MaterialCommunityIconsIcon name="book" style={styles.icon3} />
      </TouchableOpacity>
      <TouchableOpacity style={styles.buttonWrapper4}>
        <MaterialCommunityIconsIcon name="calendar-text" style={styles.icon4} />
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: "#3f51b5",
    flexDirection: "row",
    alignItems: "center",
    elevation: 3,
    shadowOffset: {
      height: -2,
      width: 0
    },
    shadowColor: "#111",
    shadowOpacity: 0.2,
    shadowRadius: 1.2
  },
  buttonWrapper1: {
    flex: 1,
    alignItems: "center",
    minWidth: 80,
    maxWidth: 168
  },
  icon1: {
    backgroundColor: "transparent",
    color: "#FFFFFF",
    fontSize: 24,
    opacity: 0.8
  },
  buttonWrapper2: {
    flex: 1,
    alignItems: "center",
    minWidth: 80,
    maxWidth: 168
  },
  activeIcon: {
    backgroundColor: "transparent",
    color: "#FFFFFF",
    fontSize: 24,
    opacity: 1
  },
  buttonWrapper3: {
    flex: 1,
    alignItems: "center",
    minWidth: 80,
    maxWidth: 168
  },
  icon3: {
    backgroundColor: "transparent",
    color: "#FFFFFF",
    fontSize: 24,
    opacity: 0.8
  },
  buttonWrapper4: {
    flex: 1,
    alignItems: "center",
    minWidth: 80,
    maxWidth: 168
  },
  icon4: {
    backgroundColor: "transparent",
    color: "#FFFFFF",
    fontSize: 24,
    opacity: 0.8
  }
});

export default MaterialIconButtonsFooter;
