import 'package:flutter/material.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: const Text("Settings"),
      centerTitle: true,
      ),
      body: const Center(
        child: Text("this is settings page",
        style: TextStyle(fontSize: 24
        ),
        ),
      ),
    );
  }
}