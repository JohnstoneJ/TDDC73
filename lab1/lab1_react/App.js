/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import type {Node} from 'react';

import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  Image,
  Button,
  Header,
  TextInput,
  TouchableOpacity,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

const Section = ({children, title}): Node => {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>

    </View>
  );

};

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };


  return (



        <View style={[styles.frame]}>

            <View style={{flex: 2, backgroundColor: "white", alignItems: 'center'}}>
            <Image source={require('./logo.png')} style={{width:'70%', height:'70%', top: '15%'}}/>
            </View>

            <View style={[styles.container_column,{ backgroundColor: "white"}]}>

              <View style={[styles.container_row]}>

                <TouchableOpacity style={styles.button}>
                  <Text style={styles.buttonText}>Button</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.button}>
                  <Text style={styles.buttonText}>Button</Text>
                </TouchableOpacity>
              </View>

              <View style={[styles.container_row]}>
                <TouchableOpacity style={styles.button}>
                  <Text style={styles.buttonText}>Button</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.button}>
                 <Text style={styles.buttonText}>Button</Text>
                </TouchableOpacity> 
              </View>

            </View>

            <View style={{flex: 1, backgroundColor: "white", alignItems:'center',}}>
            <TextInput placeholder = 'Email' style={[styles.input]}></TextInput>
            </View>


        </View>
  );
};

const styles = StyleSheet.create({
  frame: {
    flex:1,

    flexDirection: "column"
  },

  container_column: {
    flex:1,
    flexDirection: "column",
  },

  container_row: {
    flex:1,
    justifyContent: 'space-around',
    flexDirection: "row",
    alignItems:'center'
  },

  button: {
    height: 40,
    width: 100,
    backgroundColor: "#d6d7d7",
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 2
  },
  buttonText: {
    textTransform: 'uppercase',
    color: "black",
    fontSize: 15
         
  },

  input: {
    height: 40,
    width: '80%',
    margin: 12,
    borderBottomWidth: 1,
    padding: 10,
  },
});




// const styles = StyleSheet.create({
//   sectionContainer: {
//     marginTop: 32,
//     paddingHorizontal: 24,
//   },
//   sectionTitle: {
//     fontSize: 24,
//     fontWeight: '600',
//   },
//   sectionDescription: {
//     marginTop: 8,
//     fontSize: 18,
//     fontWeight: '400',
//   },
//   highlight: {
//     fontWeight: '700',
//   },
// });

export default App;
