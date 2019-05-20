import React from "react";
import { View } from "react-native";
import { FileSystem } from "expo";

class User {
  static dirname = "Users";
  static filename = "user.json";

  static load = async () => {
    const fileUri = FileSystem.documentDirectory + User.filename;
    const resultString = await FileSystem.readAsStringAsync(fileUri);
    const resultObject = JSON.parse(resultString);

    const user = new User();

    user.uuid = resultObject.uuid;
    user.name = resultObject.name;

    return user;
  };

  constructor() {
    this.uuid = "550e8400-e29b-41d4-a716-446655440000";
    this.name = "Sample User";
  }

  saveSelf = async () => {
    const fileUri = FileSystem.documentDirectory + User.filename;
    const result = await FileSystem.writeAsStringAsync(fileUri, JSON.stringify({
      uuid: this.uuid,
      name: this.name,
    }));
  };
}

export default class App extends React.Component {
  constructor(props) {
    super(props);

    (async () => {
      let user = new User();

      user.saveSelf();

      user.name = "Sample User 2";

      console.log(user);

      user = await User.load();

      console.log(user);
    })();
  }

  render() {
    return (
      <View></View>
    );
  }
}
