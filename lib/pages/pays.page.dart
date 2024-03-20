import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import '../pages/pays-details.page.dart';

class PaysPage extends StatelessWidget {
  final TextEditingController _paysController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          title: Text("Pays"),
          ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _paysController,
                decoration: InputDecoration(
                  labelText: 'Pays',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Color.fromRGBO(56, 189, 12, 0.953)),
                onPressed: () {
                  _onChercherClicked(context);
                },
                child: Text(
                  'Chercher',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChercherClicked(BuildContext context) {
    final paysSaisi = _paysController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaysDetailsPage(pays: paysSaisi),
      ),
    );
  }
}
