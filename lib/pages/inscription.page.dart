import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InscriptionPage extends StatelessWidget {
  TextEditingController txt_Login = TextEditingController();
  TextEditingController txt_Password = TextEditingController();

  Future<void> _onInscrire(BuildContext context) async {
    SnackBar snackBar = SnackBar(content: Text(""));
    if (!txt_Login.text.isEmpty && !txt_Password.text.isEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: txt_Login.text.trim(), password: txt_Password.text.trim());
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          snackBar = SnackBar(content: Text("Mot passe Faible"));
        } else if (e.code == 'email-already-in-use') {
          snackBar = SnackBar(content: Text("Email deja existant"));
        }
      }
    } else {
      snackBar = SnackBar(
        content: Text('Id ou mot de passe vides'),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Page Inscription'),
          ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_Login,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Identifiant",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              controller: txt_Password,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Mot de passe",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  ),
              onPressed: () {
                _onInscrire(context);
              },
              child: Text("Inscription", style: TextStyle(fontSize: 22)),
            ),
          ),
          TextButton(
            child: Text("J'ai déjà un compte", style: TextStyle(fontSize: 22)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/authentification');
            },
          ),
        ],
      ),
    );
  }
}
