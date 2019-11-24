import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keboen_coding_pertemuan3/src/database/users_dbhelper.dart';

import 'package:keboen_coding_pertemuan3/src/models/users_model.dart';

class CreateUsers extends StatefulWidget {
  const CreateUsers({
    this.id,
    this.username,
    this.email,
    this.password,
    this.avatar,
  });
  final int id;
  final String username;
  final String email;
  final String password;
  final String avatar;

  @override
  _CreateUsersState createState() => _CreateUsersState();
}

class _CreateUsersState extends State<CreateUsers> {
  @override
  void initState() {
    _username.text = widget.username;
    _email.text = widget.email;
    _password.text = widget.password;
    if (widget.avatar != null) {
      _file = File(widget.avatar);
    }
    super.initState();
  }

  File _file;
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[900],
      appBar: AppBar(
        title: Text('Create User'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: widget.id != null
                ? InkWell(
                    onTap: () => deleteDb(),
                    child: Icon(Icons.delete),
                  )
                : SizedBox(),
          )
        ],
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
              ),
              Container(
                child: Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(80),
                    // highlightColor: Colors.transparent,
                    // splashColor: Colors.transparent,
                    onTap: () => pickImageFromGallery(ImageSource.gallery),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: _file == null
                          ? FlutterLogo(
                              size: 150.0,
                            )
                          : Image.file(
                              _file,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Container(
                child: TextField(
                  controller: _username,
                  decoration: InputDecoration(labelText: "Username"),
                ),
              ),
              Container(
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              Container(
                child: TextField(
                  controller: _password,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 40.0),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () => saveDb(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  pickImageFromGallery(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);
    setState(() {
      _file = imageFile;
    });
  }

  Future saveDb() async {
    var db = UsersDBHelper();
    var user = Users(
      username: _username.text,
      email: _email.text,
      password: _password.text,
      avatar: _file.path,
    );
    print(user.username);
    print(user.email);
    print(user.password);
    print(user.avatar);
    // var result = await db.addUser(user);
    var result;
    if (widget.id == null) {
      result = await db.addUser(user);
    } else {
      user.id = widget.id;
      result = await db.updateUser(user, widget.id);
    }
    print(result);
    if (result != 0) {
      Navigator.of(context).pop();
    }
  }

  Future deleteDb() async {
    var db = UsersDBHelper();
    var result = await db.deleteUser(widget.id);
    print(result);
    if (result != 0) {
      Navigator.of(context).pop();
    }
    return result;
  }
}
