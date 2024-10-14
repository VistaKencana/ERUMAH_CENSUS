import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LiveDateTime extends StatefulWidget {
  const LiveDateTime({super.key});

  @override
  LiveDateTimeState createState() => LiveDateTimeState();
}

class LiveDateTimeState extends State<LiveDateTime> {
  Timer? _timer;
  String? _formattedDateTime;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _updateDateTime(); // Call it initially to set the first value
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          _updateDateTime();
        });
      }
    });
  }

  void _updateDateTime() {
    try {
      final now = DateTime.now();
      _formattedDateTime = DateFormat('yyyy-MM-dd  hh:mm:ss a').format(now);
    } catch (e) {
      _formattedDateTime = 'Error formatting date';
      debugPrint('Error updating DateTime: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formattedDateTime ?? 'Loading...',
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
