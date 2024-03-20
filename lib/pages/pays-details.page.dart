import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class PaysDetailsPage extends StatefulWidget {
  final String pays;

  PaysDetailsPage({required this.pays});

  @override
  _PaysDetailsPageState createState() => _PaysDetailsPageState();
}

class _PaysDetailsPageState extends State<PaysDetailsPage> {
  late Map<String, dynamic> paysDetails;
  late String drapeauUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPaysData(widget.pays);
  }

  Future<void> getPaysData(String pays) async {
    try {
      final response =
          await http.get(Uri.parse('https://restcountries.com/v2/name/$pays'));

      if (response.statusCode == 200) {
        setState(() {
          paysDetails = json.decode(response.body)[0];
          drapeauUrl = paysDetails['flags']
              ['svg']; // Utilisez le bon chemin pour accéder à l'URL du drapeau
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load pays details');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Page Pays Details'),
          ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  child: SvgPicture.network(
                    drapeauUrl,
                    semanticsLabel: 'Drapeau du pays',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${paysDetails['name']}',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(
                        '${utf8.decode(paysDetails['nativeName'].runes.toList())}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16.0),
                      Text('Administration',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      Row(
                        children: [
                          Text('Capitale: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${paysDetails['capital']}'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Langue(s): ${paysDetails['languages'].map((language) => utf8.decode(language['name'].runes.toList()) + ' (${utf8.decode(language['nativeName'].runes.toList())})').join(', ')}',
                      ),
                      SizedBox(height: 16.0),
                      Text('Géographie',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      Row(
                        children: [
                          Text('Région: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${paysDetails['region']}'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Superficie: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${paysDetails['area']} km²'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Fuseau Horaire: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${paysDetails['timezones'].join(', ')}'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text('Démographie',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      Row(
                        children: [
                          Text('Population: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${paysDetails['population']}'),
                        ],
                      ),
                      // Ajoutez d'autres détails en fonction de vos besoins
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
