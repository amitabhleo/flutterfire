import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String _task = "";
  void showdialog() {
    GlobalKey<FormState> formlKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Todo'),
            content: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formlKey,
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Task"),
                onChanged: (_val) {
                  _task = _val;
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    db
                        .collection("tasks")
                        .add({'task': _task, 'time': DateTime.now()});
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: showdialog,
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text('Tasks'),
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: db.collection('tasks').orderBy('time').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // return Text('has data');
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Container(
                            child: ListTile(
                              title: Text(ds['task']),
                              onLongPress: () {
                                //deletes
                                db.collection('tasks').doc(ds.id).delete();
                              },
                              onTap: () {
                                //update Data
                                db
                                    .collection('tasks')
                                    .doc(ds.id)
                                    .update({'task': "new value"});
                              },
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return CircularProgressIndicator();
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}
