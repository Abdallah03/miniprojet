import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:voyage/config/global.params.dart';
import 'package:voyage/firebase_options.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/gallerie.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/meteo.page.dart';
import 'package:voyage/pages/parametres.page.dart';
import 'package:voyage/pages/pays.page.dart';

ThemeData theme = ThemeData.light();
FirebaseDatabase firebase = FirebaseDatabase.instance;
DatabaseReference ref = firebase.ref();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GlobalParams.themeActuel.setMode(await _onGetMode());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = {
    '/home': (context) => HomePage(),
    '/authentification': (context) => AuthentificationPage(),
    '/inscription': (context) => InscriptionPage(),
    '/contact': (context) => ContactPage(),
    '/gallerie': (context) => GalleriePage(),
    '/meteo': (context) => MeteoPage(),
    '/parametres': (context) => ParametersPage(),
    '/pays': (context) => PaysPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: GlobalParams.themeActuel.getTheme(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthentificationPage();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() {});
    });
  }
}

Future<String> _onGetMode() async {
  final ref = FirebaseDatabase.instance.ref().child('mode');
  final snapshot = await ref.get();
  String mode = 'Jour'; // Mode par défaut si la valeur n'est pas présente
  if (snapshot.exists) {
    mode = snapshot.value.toString();
  }
  print(mode);
  return mode;
}
