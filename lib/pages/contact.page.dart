import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'ajout_modif_contact.page.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';

class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  ContactService contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Page Contact'),

      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: FormHelper.submitButton(
                "Ajout",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AjoutModifContactPage(),
                    ),
                  ).then((value) {
                    setState(() {}); // Rafraîchir la liste après l'ajout
                  });
                },
                borderRadius: 10,
              ),
            ),
            SizedBox(height: 10),
            _FetchData(this), // Passer la référence de ContactPageState
          ],
        ),
      ),
    );
  }
}

class _FetchData extends StatelessWidget {
  final ContactPageState parent; // Référence vers ContactPageState

  _FetchData(this.parent); // Constructeur pour recevoir la référence

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
      future: ContactService().listeContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts) {
        if (contacts.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (contacts.hasError) {
          return Center(child: Text("Erreur de chargement des contacts"));
        } else if (!contacts.hasData) {
          return Center(child: Text("Aucune donnée disponible"));
        }

        return _buildDataTable(context, contacts.data!);
      },
    );
  }

  Widget _buildDataTable(BuildContext context, List<Contact> listContacts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListUtils.buildDataTable(
        context,
        ["Nom", "Téléphone", "Action"],
        ["nom", "tel", ""],
        false,
        0,
        listContacts,
        (Contact c) {
          // Modifier contact
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjoutModifContactPage(
                modifMode: true,
                contact: c,
              ),
            ),
          );
        },
        (Contact c) {
          // Supprimer contact
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Supprimer Contact"),
                content: Text("Êtes-vous sûr de vouloir supprimer ce contact?"),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormHelper.submitButton(
                        "Oui",
                        () {
                          ContactService().supprimerContact(c).then((value) {
                            Navigator.of(context).pop();
                            parent.setState(
                                () {}); // Rafraîchir la liste après la suppression
                          });
                        },
                        width: 100,
                        borderRadius: 5,

                      ),
                      const SizedBox(width: 20),
                      FormHelper.submitButton(
                        "Non",
                        () {
                          Navigator.of(context).pop();
                        },
                        width: 100,
                        borderRadius: 5,
                      ),
                    ],
                  )
                ],
              );
            },
          );
        },
        headingRowColor: Colors.orangeAccent,
        isScrollable: true,
        columnTextFontSize: 20,
        columnTextBold: false,
        columnSpacing: 50,
        onSort: (columnIndex, columnName, asc) {},
      ),
    );
  }
}
