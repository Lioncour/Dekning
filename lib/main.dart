import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _connectionStatus = 'Checking...';

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      _checkConnectivity();
    });
  }

  void _checkConnectivity() async {
    try {
      final response = await http.get(Uri.parse('https://google.com'));
      if (response.statusCode == 200) {
        setState(() {
          _connectionStatus = 'Connected';
          _showModal();
        });
      } else {
        setState(() {
          _connectionStatus = 'Not Connected';
        });
      }
    } catch (e) {
      setState(() {
        _connectionStatus = 'Not Connected';
      });
      print('Failed to connect: $e');
    }
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 50,
        color: Colors.blue,
        child: const Center(
          child: Text('Connected', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_connectionStatus),
      ),
      body: const Center(),
    );
  }
}

