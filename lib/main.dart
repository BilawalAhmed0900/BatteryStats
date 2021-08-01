import 'package:flutter/material.dart';

void main() {
  runApp(BatteryInfo());
}

class TextWhite extends StatelessWidget {
  final String text;
  const TextWhite({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.white));
  }
}


class BatteryInfo extends StatefulWidget {
  const BatteryInfo({Key? key}) : super(key: key);

  @override
  _BatteryInfoState createState() => _BatteryInfoState();
}

class _BatteryInfoState extends State<BatteryInfo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Battery Statistics"),
          backgroundColor: Colors.grey,
        ),

        body: Center(
          child: Row(
            children: [
              TextWhite(text: "check1")
            ],
          ),
        ),

        backgroundColor: Colors.black,
      ),
    );
  }
}

