import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/model/noteModel.dart';
import 'package:login/screens/addNote.dart';
import 'package:login/screens/editNote.dart';
import 'package:login/services/authServices.dart';

class HomeScreen extends StatefulWidget {
  User user;
  HomeScreen(this.user);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Notes'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('userId', isEqualTo: widget.user.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      noteModel note =
                          noteModel.fromJson(snapshot.data.docs[index]);
                      return Card(
                        color: Colors.teal,
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          title: Text(
                            note.title,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            note.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditNote(note)));
                          },
                        ),
                      );
                    });
              }
            } else {
              return Center(
                child: Text('No notes available'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddNoteScreen(widget.user)));
          }),
    );
  }
}
