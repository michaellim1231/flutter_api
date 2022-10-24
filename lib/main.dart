import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/services/service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Email'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _loginKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email penerima", prefixIcon: Icon(Icons.email)),
                controller: ctrlEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return !EmailValidator.validate(value.toString())
                      ? 'Email tidak valid!'
                      : null;
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_loginKey.currentState!.validate()) {
            await RajaOngkirServices.sendEmail(ctrlEmail.text).then(
              (value) {
                var result = json.decode(value.body);
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("SUCCESS"),
                    content: Text(ctrlEmail.text.toString()),
                  );
                },
                );
              },
            );
          }else{
            showDialog(
              context: context, 
            builder: (context){
              return AlertDialog(
                title: Text("Failed"),
                content: Text("Please fill the form"),
              );
            },
            );

          }
        },
        tooltip: 'Send Email',
        child: Icon(Icons.send_and_archive),
      ), 
    );
  }
}
