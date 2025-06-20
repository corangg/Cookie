import 'package:flutter/material.dart';

class OvenScreen extends StatefulWidget {
  const OvenScreen({super.key});
  @override
  State<OvenScreen> createState() => _OvenScreen();
}

class _OvenScreen extends State<OvenScreen>{
  Widget build(BuildContext context) {
    return const Center(child: Text('oven'));
  }
}