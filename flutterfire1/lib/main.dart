import 'package:cloud_firestore/cloud_firestore.dart';
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
                    db.collection("tasks").add({'task': _task});
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
      body: Center(
        child: Text('Flutter'),
      ),
    ));
  }
}
