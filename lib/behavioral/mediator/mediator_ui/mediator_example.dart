import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../../../structural/bridge/bridge/bridge_example.dart';
import '../mediator.dart';
import 'notification_list.dart';

class MediatorExample extends StatefulWidget {
  const MediatorExample({super.key});

  @override
  State<StatefulWidget> createState() => _MediatorExampleState();
}

class _MediatorExampleState extends State<MediatorExample> {
  late final NotificationHub _notificationHub;
  final _admin = Admin(name: 'God');

  @override
  void initState() {
    super.initState();

    final members = [
      _admin,
      Developer(name: 'Sea Sharp'),
      Developer(name: 'Jan Assembler'),
      Developer(name: 'Dove Dart'),
      Tester(name: 'Cori Debugger'),
      Tester(name: 'Tania Mocha'),
    ];
    _notificationHub = TeamNotificationHub(members: members);
  }

  void _sendToAll() {
    setState(() {
      _admin.send('Hello');
    });
  }

  void _sendToQa() {
    setState(() {
      _admin.sendTo<Tester>('BUG!');
    });
  }

  void _sendToDevelopers() {
    setState(() {
      _admin.sendTo<Developer>('Hello, World!');
    });
  }

  void _addTeamMember() {
    final String name = '${faker.person.firstName()} ${faker.person.lastName()}';
    final TeamMember teamMember = faker.randomGenerator.boolean()
        ? Tester(name: name)
        : Developer(name: name);

    setState(() {
      _notificationHub.register(teamMember);
    });
  }

  void _sendFromMember(TeamMember member) {
    setState(() {
      member.send('Hello from ${member.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PlatformButton(
                text: "Admin: Send 'Hello' to all",
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _sendToAll,
              ),
              PlatformButton(
                text: "Admin: Send 'BUG!' to QA",
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _sendToQa,
              ),
              PlatformButton(
                text: "Admin: Send 'Hello, World!' to Developers",
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _sendToDevelopers,
              ),
              const Divider(),
              PlatformButton(
                text: "Add team member",
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _addTeamMember,
              ),
              const SizedBox(height: 12),
              NotificationList(
                members: _notificationHub.getTeamMembers(),
                onTap: (e) => _sendFromMember(e),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
