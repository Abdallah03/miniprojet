import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyage/config/global.params.dart';
import 'package:voyage/menu/drawer.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Page Home'),
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Text("Utilisateur: ${user?.email}",
                  style: TextStyle(fontSize: 22)),
              ),
          Center(
            child: Wrap(
              children: [
                ...(GlobalParams.accueil as List).map((item) {
                  return InkWell(
                    onTap: () {
                      if (item["route"] != "/authentification") {
                        Navigator.pushNamed(context, item['route']);
                      } else {
                        _deconnexion(context);
                      }
                    },
                    child: Ink.image(
                      height: 180,
                      width: 180,
                      image: item['image'],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deconnexion(context) async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/authentification', (Route<dynamic> route) => false);
  }
}
