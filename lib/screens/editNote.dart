import 'package:flutter/material.dart';
import 'package:login/model/noteModel.dart';
import 'package:login/services/notesServices.dart';

class EditNote extends StatefulWidget {
  noteModel note;
  EditNote(this.note);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Please Confirm'),
                        content: Text('Are you sure to delete this note'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await FirestoreServices()
                                    .deletNote(widget.note.id);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('Yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'))
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                controller: descriptionController,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (titleController.text == "" ||
                              descriptionController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("All fields are required")));
                          } else {
                            setState(() {
                              loading = true;
                            });
                            await FirestoreServices().updateNote(
                                widget.note.id,
                                titleController.text,
                                descriptionController.text);

                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Edit Note',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
