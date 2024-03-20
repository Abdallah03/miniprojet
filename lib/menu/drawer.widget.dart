import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  Future<void> _deconnexion(context) async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/authentification', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white, Colors.blue]),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/profil.png"),
                radius: 80,
              ),
            ),
          ),
          // Parcourir les différents éléments du menu
          ...(GlobalParams.menus as List).expand((item) {
            return [
              ListTile(
                title: Text(
                  '${item['title']}',
                  style: TextStyle(fontSize: 22),
                ),
                leading: item['icon'],
                trailing: Icon(Icons.arrow_right, color: Colors.blue),
                onTap: () async {
                  if (item['title'] != "Déconnexion") {
                    // Navigation vers la route spécifiée
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, "${item['route']}");
                  } else {
                    // Déconnexion
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/authentification', (Route<dynamic> route) => false);
                  }
                },
              ),
              Divider(
                height: 4,
                color: Colors.blue,
              ), // Séparateur
            ];
          }).toList(),
        ],
      ),
    );
  }
}
