import 'dart:async';

import 'convert.dart';
import 'package:carlos_teori/Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'feedback.dart';
import 'home.dart';

class TimeConverter extends StatefulWidget {
  @override
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  int _currentIndex = 1;

  late DateTime _currentTime; // Declare as late so it can be initialized in initState
  DateTime _selectedTime = DateTime.now();
  String _selectedTimeZone = 'WIB'; // Initial dropdown value

  String _formatTime(DateTime time, String timeZone) {
    return DateFormat('HH:mm:ss', 'en_US')
        .add_jm()
        .format(time.toUtc())
        .toString() +
        ' $timeZone';
  }

  @override
  void initState() {
    super.initState();
    // Initialize _currentTime and start the timer
    _currentTime = DateTime.now();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Converter'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[600],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 400,
          width: 400,
          child: Card(
            color: Colors.pinkAccent[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Waktu sekarang:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _formatTime(_currentTime, 'GMT'),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                DropdownButton<String>(
                  value: _selectedTimeZone,
                  onChanged: (String? value) {
                    setState(() {
                      // Handle dropdown item selection
                      if (value == 'WIB') {
                        _selectedTime = _currentTime.toUtc().add(Duration(hours: 7));
                      } else if (value == 'WITA') {
                        _selectedTime = _currentTime.toUtc().add(Duration(hours: 8));
                      } else if (value == 'WIT') {
                        _selectedTime = _currentTime.toUtc().add(Duration(hours: 9));
                      } else if (value == 'London') {
                        _selectedTime = _currentTime.toUtc(); // Set London time as UTC
                      }
                      _selectedTimeZone = value!;
                    });
                  },
                  items: ['WIB', 'WITA', 'WIT', 'London'].map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ).toList(),
                  style: TextStyle(color: Colors.white),
                  dropdownColor: Colors.pink[300],
                ),
                SizedBox(height: 32),
                Text(
                  'Waktu yang dipilih:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _formatTime(_selectedTime, _selectedTimeZone),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pinkAccent[100],
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Convert()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FeedbackForm()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Beranda',
            backgroundColor: Colors.pinkAccent[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.autorenew_rounded),
            label: 'Konversi',
            backgroundColor: Colors.pinkAccent[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            label: 'Feedback',
            backgroundColor: Colors.pinkAccent[100],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
            backgroundColor: Colors.pinkAccent[100],
          ),
        ],
      ),
    );
  }
}
