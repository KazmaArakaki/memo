import React from "react";

import {
  FlatList,
  Text,
  TouchableOpacity,
  View,
} from "react-native";

import Swipeable from "react-native-swipeable-row";

export default class extends React.Component {
  constructor(props) {
    super(props);

    this.swipeables = {};

    this.state = {
      items: [
        { name: "Item 1", key: "item-1" },
        { name: "Item 2", key: "item-2" },
        { name: "Item 3", key: "item-3" },
        { name: "Item 4", key: "item-4" },
        { name: "Item 5", key: "item-5" },
        { name: "Item 6", key: "item-6" },
        { name: "Item 7", key: "item-7" },
        { name: "Item 8", key: "item-8" },
        { name: "Item 9", key: "item-9" },
        { name: "Item 10", key: "item-10" },
      ],
    };
  }

  render() {
    return (
      <FlatList
          data={this.state.items}
          keyExtractor={(item) => (item.key)}
          renderItem={({ item, index }) => {
            return (
              <Swipeable
                  ref={(ref) => {
                    this.swipeables[index] = ref;
                  }}
                  onRightActionRelease={() => {
                    this.recenterTheRestSwipeables(index);
                  }}
                  rightButtons={[
                    (
                      <TouchableOpacity style={{ flex: 1, backgroundColor: "#ff2600", justifyContent: "center" }}
                          onPress={() => {
                            this.recenterTheRestSwipeables(null);
                          }}>
                        <Text style={{ width: 75, textAlign: "center", color: "#fff", fontWeight: "bold" }}>
                          削除
                        </Text>
                      </TouchableOpacity>
                    ),
                  ]}>
                <TouchableOpacity style={{ paddingTop: 12, paddingRight: 16, paddingBottom: 12, paddingLeft: 16 }}
                    onPress={() => {
                      this.recenterTheRestSwipeables(null);
                    }}>
                  <Text>
                    {item.name}
                  </Text>
                </TouchableOpacity>
              </Swipeable>
            );
          }}
          ItemSeparatorComponent={() => (
            <View style={{ width: "100%", height: 1, backgroundColor: "#ccc" }} />
          )} />
    );
  };

  recenterTheRestSwipeables = (passedIndex) => {
    for (const index in this.swipeables) {
      const swipeable = this.swipeables[index];

      if (Number.parseInt(index) !== passedIndex) {
        swipeable.recenter();
      }
    }
  };
}
