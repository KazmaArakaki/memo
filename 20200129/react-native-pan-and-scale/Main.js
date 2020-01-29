import React from "react";

import {
  Animated,
  Image,
  PanResponder,
  View,
} from "react-native";

export default class MainComponnt extends React.Component {
  static navigationOptions = ({ navigation }) => ({
    title: "Pan And Scale",
  });

  constructor(props) {
    super(props);

    this._isMounted = false;
    this._scaleCache = 1;
    this._translateOffsetX = 0;
    this._translateOffsetY = 0;

    this.state = {
      scale: new Animated.Value(1),
      translate: new Animated.ValueXY(),
      imageSize: {
        originalWidth: 50,
        originalHeight: 50,
      },
    };

    this.state.translate.x.addListener(({ value }) => {
      this._translateOffsetX = value;
    });

    this.state.translate.y.addListener(({ value }) => {
      this._translateOffsetY = value;
    });

    this.panResponder = PanResponder.create({
      onShouldBlockNativeResponder: (event, gestureState) => (true),
      onStartShouldSetPanResponder: (event, gestureState) => (true),
      onStartShouldSetPanResponderCapture: (event, gestureState) => (true),
      onMoveShouldSetPanResponder: (event, gestureState) => (true),
      onMoveShouldSetPanResponderCapture: (event, gestureState) => (true),

      onPanResponderGrant: (event, gestureState) => {
        this._scaleCache = this.state.scale._value;

        this.state.translate.setOffset({
          x: this._translateOffsetX,
          y: this._translateOffsetY,
        });

        this.state.translate.setValue({
          x: 0,
          y: 0,
        });
      },
      onPanResponderMove: (event, gestureState) => {
        if (gestureState.numberActiveTouches >= 2) {
          const touch1 = event.touchHistory.touchBank[0];
          const touch2 = event.touchHistory.touchBank[1];

          const startDistance = Math.hypot(touch1.startPageX - touch2.startPageX, touch1.startPageY - touch2.startPageY);
          const currentDistance = Math.hypot(touch1.currentPageX - touch2.currentPageX, touch1.currentPageY - touch2.currentPageY);
          const resizeRatio = this._scaleCache * (currentDistance / startDistance);

          this.state.scale.setValue(resizeRatio);
        } else if (gestureState.numberActiveTouches >= 1) {
          const touch = event.touchHistory.touchBank[0];

          this.state.translate.setValue({
            x: touch.currentPageX - touch.startPageX,
            y: touch.currentPageY - touch.startPageY,
          });
        }
      },
      onPanResponderRelease: (event, gestureState) => {
        this.state.translate.flattenOffset();
      },
    });
  }

  componentDidMount() {
    this._isMounted = true;
  }

  componentWillUnmount() {
    this._isMounted = false;
  }

  render() {
    return (
      <View style={{
            flex: 1,
            flexDirection: "column",
            backgroundColor: "#333333",
            justifyContent: "center",
            alignItems: "center",
          }}>
        <View {...this.panResponder.panHandlers} style={{
              width: "90%",
              height: "40%",
              backgroundColor: "#666666",
              overflow: "hidden",
            }}>
          <Animated.View style={{
                width: this.state.imageSize.originalWidth,
                height: this.state.imageSize.originalHeight,
                transform: [
                  { translateX: this.state.translate.x },
                  { translateY: this.state.translate.y },
                ],
              }}>
            <Animated.View style={{
                  width: this.state.imageSize.originalWidth,
                  height: this.state.imageSize.originalHeight,
                  transform: [
                    { scaleX: this.state.scale },
                    { scaleY: this.state.scale },
                  ],
                }}>
              <Image style={{
                    width: this.state.imageSize.originalWidth,
                    height: this.state.imageSize.originalHeight,
                  }}
                  source={{
                    uri: "https://www.pakutaso.com/shared/img/thumb/007KZ1123FOTO_TP_V.jpg",
                  }}
                  onLoad={this.onImageLoadHandler}
              />
            </Animated.View>
          </Animated.View>
        </View>
      </View>
    );
  }

  onImageLoadHandler = (event) => {
    this._isMounted && this.setState({
      imageSize: {
        originalWidth: event.nativeEvent.source.width,
        originalHeight: event.nativeEvent.source.height,
      },
    });
  };
}
