import React from "react";
import { View, Image } from "react-native";
import { Asset, FileSystem } from "expo";

class User {
  static dirname = "Users";

  constructor() {
    this.uuid = "550e8400-e29b-41d4-a716-446655440000";
    this.name = "Sample User";
    this.asset = new Asset({
      name: this.uuid,
      type: "jpg",
    });
  }

  downloadImage = async () => {
    return new Promise(async (resolve, reject) => {
      const dirname = FileSystem.documentDirectory + User.dirname;
      const dirInfo = await FileSystem.getInfoAsync(dirname);

      if (!dirInfo.exists) {
        const res = await FileSystem.makeDirectoryAsync(dirname);
      }

      const localUri = `${dirname}/${this.asset.name}.${this.asset.type}`;

      const { md5: hash, uri } = await FileSystem.downloadAsync(this.asset.uri, localUri, { md5: true }).catch((error) => {
        reject(error);
      });

      this.asset.localUri = uri;
      this.asset.hash = hash;
      this.asset.downloaded = true;

      Image.getSize(uri, (width, height) => {
        this.asset.width = width;
        this.asset.height = height;

        resolve();
      });
    });
  };
}

export default class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      user: new User(),
    };

  }

  componentDidMount() {
    this.state.user.asset.uri = "https://via.placeholder.com/128?text=Sample";
    this.state.user.downloadImage().then(() => {
      this.setState({
        user: this.state.user,
      });
    }).catch((error) => {
    });
  }

  render() {
    return (
      <View>
        <Image style={{
              width: this.state.user.asset.width || 0,
              height: this.state.user.asset.height || 0,
            }}
            source={{ uri: this.state.user.asset.localUri || null }} />
      </View>
    );
  }
}
