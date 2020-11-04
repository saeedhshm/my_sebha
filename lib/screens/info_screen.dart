import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('عن التطبيق',
        style: TextStyle(fontFamily: 'Antic Decorative', letterSpacing: 3.0),
      ),centerTitle: true,),
    );
  }
}
