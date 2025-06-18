import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  final String activity;

  const TimerPage({required this.activity, Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int seconds = 0;
  Timer? timer;

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      seconds = 0;
    });
  }

  double getSpeed() {
    switch (widget.activity.toLowerCase()) {
      case 'running':
        return 8.0;
      case 'cycling':
        return 15.0;
      case 'sprinting':
        return 20.0;
      default:
        return 5.0;
    }
  }

  double calculateDistanceInKm() {
    double speed = getSpeed(); // km/h
    double hours = seconds / 3600;
    return speed * hours;
  }

  void saveEntry() {
    if (seconds == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Timer is at zero. Start the timer first!")),
      );
      return;
    }

    double distanceKm = calculateDistanceInKm();
    String formattedDuration =
        "${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}";

    Map<String, dynamic> entry = {
      'activity': widget.activity,
      'duration': formattedDuration,
      'distance': double.parse(distanceKm.toStringAsFixed(2)),
    };

    Navigator.pop(context, entry); // return data to HomePage
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    final distanceKm = calculateDistanceInKm();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      appBar: AppBar(
        title: Text("${widget.activity} Timer"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.activity,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "$minutes:$secs",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Distance: ${distanceKm.toStringAsFixed(2)} km",
                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
              ),
              SizedBox(height: 30),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: startTimer,
                    icon: Icon(Icons.play_arrow, color: Colors.black),
                    label: Text("Start", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: stopTimer,
                    icon: Icon(Icons.pause, color: Colors.black),
                    label: Text("Stop", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: resetTimer,
                    icon: Icon(Icons.replay, color: Colors.black),
                    label: Text("Reset", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: saveEntry,
                    icon: Icon(Icons.save, color: Colors.black),
                    label: Text("Save", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
