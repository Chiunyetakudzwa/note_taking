import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class noteModel {
  String id;
  String title;
  String description;
  Timestamp date;
  String userId;

  noteModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.userId});

  factory noteModel.fromJson(DocumentSnapshot snapshot) {
    return noteModel(
        id: snapshot.id,
        title: snapshot['title'],
        description: snapshot['description'],
        date: snapshot['date'],
        userId: snapshot['userId']);
  }
}
