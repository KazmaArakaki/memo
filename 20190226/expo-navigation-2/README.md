``` javascript
import React from "react";

import {
  Button,
  StyleSheet,
  Text,
  View,
} from "react-native";

import {
  createAppContainer,
  createStackNavigator,
} from "react-navigation";

class HomeScreen extends React.Component {
  static navigationOptions = {
    title: "Home",
  };

  render() {
    return (
      <View style={styles.container}>
        <Text>Home Screen</Text>

        <Button
            title="Go to Details"
            onPress={() => {
              this.props.navigation.navigate("Details", {
                itemId: 86,
                otherParam: "anything you want here",
              });
            }} />
      </View>
    );
  }
}

class DetailsScreen extends React.Component {
  static navigationOptions = {
    title: "Home",
  };

  render() {
    const itemId = this.props.navigation.getParam("itemId", "NO-ID");
    const otherParam = this.props.navigation.getParam("otherParam", "some default value");

    return (
      <View style={styles.container}>
        <Text>Details Screen</Text>

        <Text>itemId: {JSON.stringify(itemId)}</Text>

        <Text>otherParam: {JSON.stringify(otherParam)}</Text>

        <Button
            title="PUSH"
            onPress={() => {
              this.props.navigation.push("Details", {
                itemId: Math.floor(Math.random() * 100),
              });
            }} />
      </View>
    );
  }
}

const AppNavigator = createStackNavigator({
  Home: {
    screen: HomeScreen,
  },
  Details: {
    screen: DetailsScreen,
  },
}, {
  initialRouteName: "Home",
});

const AppContainer = createAppContainer(AppNavigator);

export default class App extends React.Component {
  render() {
    return <AppContainer />;
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
});
```
