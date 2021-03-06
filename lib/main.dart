import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:flutter/cupertino.dart';
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
    return Text(text, style: TextStyle(color: Colors.white70));
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

  double normalizeBatteryCurrent(double current, ChargingStatus status) {
    if (status == ChargingStatus.Discharging) {
      return current.abs() * -1;
    }

    return current.abs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Battery Statistics", style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.grey.shade900,
            leading: Icon(Icons.battery_charging_full_rounded, color: Colors.white, size: 30,),
            bottom: PreferredSize(
              child: Container(
                color: Colors.grey.shade800,
                height: 1,
              ),
              preferredSize: Size.fromHeight(1),
            ),
          ),

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWhite(text: "Battery Level: " + (batteryInfo != null
                    ?  batteryInfo!.batteryLevel!.toString() + "%"
                    : "Calculating...")),
                TextWhite(text: "",),
                TextWhite(text: "Battery Energy: " + (batteryInfo != null
                    ? (-batteryInfo!.remainingEnergy! * 1.0E-9).toStringAsFixed(4) + " Wh"
                    : "Calculating...")),
                TextWhite(text: "",),
                TextWhite(text: "Battery Temperature: " + (batteryInfo != null
                    ? batteryInfo!.temperature!.toString() + " ??C"
                    : "Calculating...")),
                TextWhite(text: "",),
                TextWhite(text: "Battery Technology: " + (batteryInfo != null
                    ? batteryInfo!.technology!
                    : "Calculating...")),
                TextWhite(text: "",),
                TextWhite(text: "Battery Current: " + (batteryInfo != null
                    ? (normalizeBatteryCurrent(batteryInfo!.currentNow! / 1000, batteryInfo!.chargingStatus!)).toStringAsFixed(0) + " mA"
                    : "Calculating...")),
                TextWhite(text: "",),
                TextWhite(text: "Battery Voltage: " + (batteryInfo != null
                    ? (batteryInfo!.voltage! / 1000).toString() + " V"
                    : "Calculating...")),
                TextWhite(text: "",),
                TextWhite(text: "Battery Status: " + (batteryInfo != null
                    ? batteryInfo!.chargingStatus!.toString().split(".")[1]
                    : "Calculating...")),
                TextWhite(text: "",),
                TextWhite(text: "",),
                TextWhite(text: "",),
                TextWhite(text: "ICON BY prettycon AT flaticons.com",),
              ],
            ),
          ),
          backgroundColor: Colors.grey.shade900,
        ),
      ),
    );
  }
}

