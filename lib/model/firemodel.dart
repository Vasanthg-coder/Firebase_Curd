class Contact {
  final String id;
  final String name;
  final String phone;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
  });

  // Factory method to create a Contact object from a Firestore document
  factory Contact.fromDocument(Map<String, dynamic> doc, String id) {
    return Contact(
      id: id,
      name: doc['name'] ?? '',
      phone: doc['phone'] ?? '',
    );
  }
}
