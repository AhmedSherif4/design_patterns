import 'package:flutter/material.dart';

import 'adapter.dart';

class AdapterExample extends StatelessWidget {
  const AdapterExample({super.key});

  @override
  Widget build(BuildContext context) {
    List<Contact> jsonC = JsonContactsAdapter().getContacts();
    List<Contact> xmlC = XmlContactsAdapter().getContacts();
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...jsonC.map((contact) => Text('''
${contact.email},
${contact.favourite},
${contact.fullName},
''')).toList(),
              ...xmlC.map((contact) => Text('''
${contact.email},
${contact.favourite},
${contact.fullName},
''')).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
