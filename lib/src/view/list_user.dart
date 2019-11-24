import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keboen_coding_pertemuan3/src/database/users_dbhelper.dart';
import 'package:keboen_coding_pertemuan3/src/models/users_model.dart';
import 'package:keboen_coding_pertemuan3/src/view/create_users.dart';

class ListUsers extends StatefulWidget {
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  UsersDBHelper _dbHelper = UsersDBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Users'),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => CreateUsers(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: _dbHelper.getAllUsers(),
          builder: (BuildContext ctx, AsyncSnapshot<List<Users>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => CreateUsers(
                            id: snapshot.data[index].id,
                            username: snapshot.data[index].username,
                            email: snapshot.data[index].email,
                            password: snapshot.data[index].password,
                            avatar: snapshot.data[index].avatar,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: snapshot.data[index].avatar == null
                                ? FlutterLogo(
                                    size: 40.0,
                                    style: FlutterLogoStyle.stacked,
                                  )
                                : Image.file(
                                    File(snapshot.data[index].avatar),
                                  ),
                            title: Text(snapshot.data[index].username),
                            subtitle: Text(snapshot.data[index].email),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('Tidak Ada Data'),
                );
              }
            } else {
              return SizedBox();
            }
          },
        ));
  }
}
