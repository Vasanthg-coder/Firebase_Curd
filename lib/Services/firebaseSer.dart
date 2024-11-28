import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/firemodel.dart';

class FirebaseData {
  List data = [];
  static Future addContact(id, contactdetails) async {
    return await FirebaseFirestore.instance
        .collection('contact')
        .doc(id)
        .set(contactdetails);
  }

  Stream<List<Contact>> getContacts() {
    return FirebaseFirestore.instance
        .collection('contact')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Contact.fromDocument(doc.data(), doc.id);
      }).toList();
    });
  }

  Future updateContact(id, contactdetails) async {
    return await FirebaseFirestore.instance
        .collection('contact')
        .doc(id)
        .update(contactdetails);
  }

  static Future deleteContact(id) async {
    return await FirebaseFirestore.instance
        .collection('contact')
        .doc(id)
        .delete();
  }
}
