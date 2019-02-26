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
  render() {
    return (
      <View style={styles.container}>
        <Text>Home Screen</Text>

        <Button title="Go to Details" onPress={() => this.props.navigation.navigate("Details")} />
      </View>
    );
  }
}

class DetailsScreen extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Details Screen</Text>

        <Button title="NAVIGATE" onPress={() => this.props.navigation.navigate("Details")} />

        <Button title="PUSH" onPress={() => this.props.navigation.push("Details")} />

        <Button title="GO BACK" onPress={() => this.props.navigation.goBack()} />

        <Button title="POP TO TOP" onPress={() => this.props.navigation.popToTop()} />
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
