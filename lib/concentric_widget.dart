import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'concentric_clock.dart';

class ConcentricWidget extends StatefulWidget {
  const ConcentricWidget({
    super.key,
  });

  @override
  State<ConcentricWidget> createState() => _ConcentricWidgetState();
}

class _ConcentricWidgetState extends State<ConcentricWidget> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var dateTime = DateTime.now();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('hh : mm : ss').format(dateTime),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: size.height * 0.5,
            width: size.height * 0.5,
            child: CustomPaint(
              painter: ConcentricClock(),
            ),
          ),
        ],
      ),
    );
  }
}
