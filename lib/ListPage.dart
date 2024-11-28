import 'package:firebase_curd/Services/firebaseSer.dart';
import 'package:flutter/material.dart';
import 'editContact.dart';
import 'model/firemodel.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  late Stream<List<Contact>> contact;
  bool loading = false;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    contact = FirebaseData().getContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: contact,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No contacts available'),
          );
        }
        final contacts = snapshot.data!;
        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    contact.name.isNotEmpty
                        ? contact.name[0].toUpperCase()
                        : "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  contact.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  contact.phone,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                trailing: SizedBox(
                  width: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          EditContactDialog.show(
                            context: context,
                            Id: contact.id,
                            Phone: contact.phone,
                            Name: contact.name,
                          );
                        },
                        child: const Icon(Icons.edit, color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseData.deleteContact(contact.id);
                        },
                        child: const Icon(Icons.delete_rounded,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
