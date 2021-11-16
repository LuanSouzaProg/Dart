import 'dart:io';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'contact_page.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { orderaz, orderza }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contatcs = [];

  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de A-Z"),
                value: OrderOptions.orderaz,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de Z-A"),
                value: OrderOptions.orderza,
              ),
            ],
            onSelected: _orderList,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: contatcs.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: contatcs[index].img != null
                            ? FileImage(File(contatcs[index].img!))
                            : const AssetImage("images/person.png")
                                as ImageProvider)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contatcs[index].name ?? "",
                      style: const TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contatcs[index].email ?? "",
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      contatcs[index].phone ?? "",
                      style: const TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        child: const Text(
                          "Ligar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          launch("tel:${contatcs[index].phone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        child: const Text(
                          "Editar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showContactPage(contact: contatcs[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        child: const Text(
                          "Excluir",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          helper.deleteContact(contatcs[index].id);
                          setState(() {
                            contatcs.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            onClosing: () {},
          );
        });
  }

  void _showContactPage({Contact? contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));

    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
        _getAllContacts();
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((List<Contact> list) {
      setState(() {
        contatcs = list;
      });
    });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        contatcs.sort((a, b) {
          return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
        });
        break;

      case OrderOptions.orderza:
        contatcs.sort((a, b) {
          return b.name!.toLowerCase().compareTo(a.name!.toLowerCase());
        });
        break;
    }
    setState(() {});
  }
}
