Setting up development environment for React Native on Ubuntu 16.04 LTS.

## Install required packages

```
~$ sudo apt install vim git libtool m4 automake libssl-dev python2.7-dev
```

## Install Java Development Kit and gradle

```
~$ sudo apt install openjdk-8-jdk gradle
~$ vim .bashrc
```

**.bashrc**

```
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-i386
```

```
~$ source .bashrc
```

## Install Android Software Development Kit

* Download [sdk-tools-linux](https://developer.android.com/studio/index.html#downloads)

```
~$ unzip sdk-tools-linux-3859397.zip
~$ sudo mkdir /usr/lib/android-sdk
~$ sudo mv tools/ /usr/lib/android-sdk/
~$ vim .bashrc
```

**.bashrc**

```
export ANDROID_HOME=/usr/lib/android-sdk
```

```
~$ source .bashrc
~$ sudo ln -s /usr/lib/android-sdk/tools/bin/sdkmanager /usr/local/bin/adkmanager
~$ sudo ln -s /usr/lib/android-sdk/tools/bin/avdmanager /usr/local/bin/avdmanager
~$ sudo adkmanager "tools"
~$ sudo adkmanager "platforms;android-23"
~$ sudo adkmanager "build-tools;23.0.1"
~$ sudo adkmanager "system-images;android-19;google_apis;x86"
~$ avdmanager create avd -n testavd -k "system-images;android-19;google_apis;x86"
~$ sudo /usr/lib/android-sdk/tools/emulator -avd testavd
```

## Install Nodejs 

```
~$ wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.7/install.sh | bash
~$ vim .bashrc
```

**.bashrc**

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
```

```
~$ nvm version-remote --lts
~$ nvm install v8.9.3
```

## Install watchman

* [Ref](https://facebook.github.io/watchman/docs/install.html#installing-from-source)

```
       ~$ git clone https://github.com/facebook/watchman.git
       ~$ cd watchman
watchman$ git checkout v4.9.0  # the latest stable release
watchman$ ./autogen.sh
watchman$ ./configure
watchman$ vim Makefile
```

**Makefile**

```
LIBS = -lcrypto -lpthread -lssl
```

```
watchman$ make
watchman$ sudo make install
watchman$ cd ~
       ~$ sudo rm -rf watchman
```

## Install react-native-cli

```
~$ npm install -g react-native-cli
```

## Create React Native project

```
~$ react-native init Native
```
