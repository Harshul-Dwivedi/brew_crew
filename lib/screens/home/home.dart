import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.green[400]),
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text(
                'Logout',
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              style: ElevatedButton.styleFrom(primary: Colors.green[400]),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/coffee_bg.jpeg'),
              fit: BoxFit.cover,
            )),
            child: BrewList()),
      ),
    );
  }
}
