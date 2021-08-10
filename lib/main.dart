import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'dart:async';

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
  AndroidBatteryInfo? batteryInfo;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(
      seconds: 1
    ), (timer) {
      BatteryInfoPlugin().androidBatteryInfo.then((value) {
        setState(() {
          batteryInfo = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Battery Statistics"),
          backgroundColor: Colors.grey,
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWhite(text: "Battery Level: " + (batteryInfo != null ? batteryInfo!.batteryLevel!.toString() + " %" : "Calculating...")),
              TextWhite(text: "",),
              TextWhite(text: "Battery Energy: " + (batteryInfo != null ? (-batteryInfo!.remainingEnergy! * 1.0E-9).toStringAsFixed(4) + " Wh"  : "Calculating...")),
              TextWhite(text: "",),
              TextWhite(text: "Battery Temperature: " + (batteryInfo != null ? batteryInfo!.temperature!.toString() + " C" : "Calculating...")),
              TextWhite(text: "",),
              TextWhite(text: "Battery Technology: " + (batteryInfo != null ? batteryInfo!.technology! : "Calculating...")),
              TextWhite(text: "",),
              TextWhite(text: "Battery Current: " + (batteryInfo != null ? (batteryInfo!.currentNow! / 1000 * -1).toStringAsFixed(0) + " mA" : "Calculating...")),
              TextWhite(text: "",),
              TextWhite(text: "Battery Voltage: " + (batteryInfo != null ? (batteryInfo!.voltage! / 1000).toString() + " V": "Calculating...")),
              TextWhite(text: "",),
              TextWhite(text: "Battery Status: " + (batteryInfo != null ? batteryInfo!.chargingStatus!.toString().split(".")[1] : "Calculating...")),
              TextWhite(text: "",),
              TextWhite(text: "",),
              TextWhite(text: "",),
              TextWhite(text: "ICON BY prettycon AT flaticons.com",),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

