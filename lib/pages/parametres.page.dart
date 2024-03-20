import 'package:flutter/material.dart';
import 'package:voyage/config/global.params.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'package:firebase_database/firebase_database.dart';

String mode = "Jour";
FirebaseDatabase firebase = FirebaseDatabase.instance;
DatabaseReference ref = firebase.ref();

class ParametersPage extends StatefulWidget {
  @override
  State<ParametersPage> createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Page Paramètres'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Mode", style: TextStyle(fontSize: 22)),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text("Jour"),
                leading: Radio<String>(
                  value: "Jour",
                  groupValue: mode,
                  onChanged: (value) {
                    setState(() {
                      mode = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Nuit"),
                leading: Radio<String>(
                  value: "Nuit",
                  groupValue: mode,
                  onChanged: (value) {
                    setState(() {
                      mode = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                _onSaveMode();
              },
              child: Text('Enregistrer', style: TextStyle(fontSize: 22)),
            ),
          ),
        ],
      ),
    );
  }

  _onSaveMode() async {
    // Modification du mode du thème global
    GlobalParams.themeActuel.setMode(mode);
    await ref.set({"mode": mode});
    print("mode appliqué : $mode");
    Navigator.pop(context);
  }
}
