import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationPage extends StatelessWidget {
  TextEditingController txt_Login = TextEditingController();
  TextEditingController txt_Password = TextEditingController();

  Future<void> _onAuthentifier(BuildContext context) async {
    SnackBar snackBar = SnackBar(content: Text(""));
    if (!txt_Login.text.isEmpty && !txt_Password.text.isEmpty) {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txt_Login.text.trim(),
          password: txt_Password.text.trim(),
        );
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          snackBar = SnackBar(
            content: Text('Utilisateur inexistant.'),
          );
        } else if (e.code == 'wrong-password') {
          snackBar = SnackBar(
            content: Text("Vérifier votre mot de passe."),
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      snackBar = SnackBar(
        content: Text('Id ou mot de passe vides.'),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Page Authentification'),
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
                _onAuthentifier(context);
              },
              child: Text("Connexion", style: TextStyle(fontSize: 22)),
            ),
          ),
          TextButton(
            child: Text("Nouvel Utilisateur ? Inscrivez-vous",
                style: TextStyle(fontSize: 22)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/inscription');
            },
          ),
        ],
      ),
    );
  }
}
