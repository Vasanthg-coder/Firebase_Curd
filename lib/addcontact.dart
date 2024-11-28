import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';

import 'Services/firebaseSer.dart';

class Addcontact extends StatefulWidget {
  const Addcontact({super.key, this.name, this.mobile, this.id, this.page});
  final name;
  final mobile;
  final id;
  final page;
  @override
  State<Addcontact> createState() => _AddcontactState();
}

class _AddcontactState extends State<Addcontact> {
  @override
  void initState() {
    if (widget.page == 'Edit') {
      phoneController.text = widget.mobile;
      nameController.text = widget.name;
      id = widget.id;
    }
    super.initState();
  }

  void _clearForm() {
    nameController.clear();
    phoneController.clear();
  }

  var id;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: "Contact Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mobile Number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: phoneController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone_android),
                    hintText: "Mobile Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      id = randomAlphaNumeric(10);

                      var req = {
                        'name': nameController.text.toString().trimLeft(),
                        'phone': phoneController.text.toString().trim(),
                        'id': id
                      };
                      await FirebaseData.addContact(id, req);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Contact Saved: ${nameController.text}, ${phoneController.text},",
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      _clearForm();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please fill all fields",
                          ),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 79, 160, 200),
                    disabledForegroundColor: Colors.grey.withOpacity(0.38),
                    disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                  ),
                  child: const Text('Save Contact'),
                ),
                ElevatedButton(
                  onPressed: _clearForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
