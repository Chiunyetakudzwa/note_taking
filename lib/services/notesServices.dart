import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertNote(String title, String description, String userId) async {
    try {
      await firestore.collection('users').add({
        "title": title,
        "description": description,
        "date": DateTime.now(),
        "userId": userId,
      });
    } catch (e) {
      print((e));
    }
  }

  Future updateNote(String docId, String title, String description) async {
    try {
      await firestore.collection('users').doc(docId).update({
        'title': title,
        'description': description,
      });
    } catch (e) {
      print((e));
    }
  }

  Future deletNote(String docId) async {
    try {
      await firestore.collection('users').doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }
}
