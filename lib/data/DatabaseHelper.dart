import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'court_model.dart';

class DatabaseHelper {
  static Future<void> delete(String key) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child("courts").child(key).remove();
  }

  static Future<void> update(
      String key, CourtData castleData, BuildContext context) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference
        .child("courts")
        .child(key)
        .update(castleData.toJson()).then((_) {
      // Show a snackbar on successful update
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Operation updated successfully')),
      );
    }).catchError((error) {
      // Handle errors and show a different snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to update: ${error.toString()}')),
      );
    });
  }

  //this is to save CourtData object into firebase database real time
  // it convert CourtData to json using toJson()
  static Future<void> addNew(CourtData courtData) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    return databaseReference
        .child('padlecourt') //place where the data saved in firebase
        .push()
        .set(courtData.toJson())
        .then((value) => print("Courts created successfully!"))
        .catchError((error) => print("Failed to create castle data: $error"));
  }

  static void readFirebaseRealtimeDBMain(Function(List<Court>) castleListCallback) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("padlecourt").onValue.listen((castleDataJson) {
      if (castleDataJson.snapshot.exists) {
        CourtData castleData;
        Court castle;
        List<Court> castleList = [];
        castleDataJson.snapshot.children.forEach((element) {
//print("Element Key: ${element.key}");
//print("Element: ${element.value}");
          castleData = CourtData.fromJson(element.value as Map);
          castle = Court(element.key, castleData);
          castleList.add(castle);
        });
        castleListCallback(castleList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }

  static void createFirebaseRealtimeDBWithUniqueIDs(String mainNodeName, List<Map<String, dynamic>> fortList) {
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.ref(mainNodeName);
    if (fortList.isNotEmpty) {
      fortList.forEach((fort) {
        databaseReference
            .push()
            .set(fort)
            .then((value) => print("CourtList data successfully saved!"))
            .catchError((error) => print("Failed to write message: $error"));
      });
    } else {
      print("CourtList is empty!");
    }
  }

  static void writeMessageToFirebase() {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference
        .child('messages')
        .set({'message': 'HelloWorld'})
        .then((value) => print("Message written successfully"))
        .catchError((error) => print("Failed to write message: $error"));
  }


  static void read(Function(List<Court>) castleListCallback) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("courtList_izkai").onValue.listen((castleDataJson) {
      if (castleDataJson.snapshot.exists) {
        CourtData castleData;
        Court castle;
        List<Court> castleList = [];
        castleDataJson.snapshot.children.forEach((element) {
//print("Element Key: ${element.key}");
//print("Element: ${element.value}");
          castleData = CourtData.fromJson(element.value as Map);
          castle = Court(element.key, castleData);
          castleList.add(castle);
        });
        castleListCallback(castleList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }

  static void readmuscat(Function(List<Court>) castleListCallback) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("courtList_muscat").onValue.listen((castleDataJson) {
      if (castleDataJson.snapshot.exists) {
        CourtData castleData;
        Court castle;
        List<Court> castleList = [];
        castleDataJson.snapshot.children.forEach((element) {
//print("Element Key: ${element.key}");
//print("Element: ${element.value}");
          castleData = CourtData.fromJson(element.value as Map);
          castle = Court(element.key, castleData);
          castleList.add(castle);
        });
        castleListCallback(castleList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }
  static void readNizwa(Function(List<Court>) castleListCallback) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("courtList_Nizwa").onValue.listen((castleDataJson) {
      if (castleDataJson.snapshot.exists) {
        CourtData castleData;
        Court castle;
        List<Court> castleList = [];
        castleDataJson.snapshot.children.forEach((element) {
//print("Element Key: ${element.key}");
//print("Element: ${element.value}");
          castleData = CourtData.fromJson(element.value as Map);
          castle = Court(element.key, castleData);
          castleList.add(castle);
        });
        castleListCallback(castleList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }
  static void readSala(Function(List<Court>) castleListCallback) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("courtList_salalh").onValue.listen((castleDataJson) {
      if (castleDataJson.snapshot.exists) {
        CourtData castleData;
        Court castle;
        List<Court> castleList = [];
        castleDataJson.snapshot.children.forEach((element) {
//print("Element Key: ${element.key}");
//print("Element: ${element.value}");
          castleData = CourtData.fromJson(element.value as Map);
          castle = Court(element.key, castleData);
          castleList.add(castle);
        });
        castleListCallback(castleList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }
}
