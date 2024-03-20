import 'package:flutter/material.dart';
import 'meteo-details.page.dart';

class MeteoPage extends StatelessWidget {
  TextEditingController txt_ville = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Page Meteo'),
          backgroundColor: Color.fromRGBO(56, 189, 12, 0.953)),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_ville,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                hintText: "Ville",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
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
                _onGetMeteoDetails(context);
              },
              child: Text(
                'Chercher',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onGetMeteoDetails(BuildContext context) {
    String ville = txt_ville.text;
    txt_ville.text =
        ""; // Efface le champ de texte après avoir récupéré la ville

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeteoDetailsPage(ville),
      ),
    );
  }
}
