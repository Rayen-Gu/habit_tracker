import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
