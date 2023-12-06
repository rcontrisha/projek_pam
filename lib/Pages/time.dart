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

  late DateTime _currentTime;
  DateTime _selectedTime = DateTime.now();
  String _selectedTimeZone = 'GMT';

  String _formatTime(DateTime time, String timeZone) {
    String runningTime = DateFormat('HH:mm:ss', 'en_US')
        .format(time.toUtc())
        .toString();

    String amPmTime = DateFormat('h:mm a', 'en_US')
        .format(time.toUtc())
        .toString();

    return '$runningTime\n$amPmTime $timeZone';
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

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        // Update _selectedTime based on the selected time zone
        if (_selectedTimeZone == 'GMT') {
          _selectedTime = _currentTime;
        } else if (_selectedTimeZone == 'WIB') {
          _selectedTime = _currentTime.toUtc().add(Duration(hours: 7));
        } else if (_selectedTimeZone == 'WITA') {
          _selectedTime = _currentTime.toUtc().add(Duration(hours: 8));
        } else if (_selectedTimeZone == 'WIT') {
          _selectedTime = _currentTime.toUtc().add(Duration(hours: 9));
        } else if (_selectedTimeZone == 'London') {
          _selectedTime = _currentTime.toUtc();
        }
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
                Center(
                  child: Column(
                    children: [
                      Text(
                        _formatTime(_selectedTime, _selectedTimeZone).split('\n')[0],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _formatTime(_selectedTime, _selectedTimeZone).split('\n')[1],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                        _selectedTime = _currentTime.toUtc();
                      }
                      _selectedTimeZone = value!;
                    });
                  },
                  items: ['GMT', 'WIB', 'WITA', 'WIT', 'London'].map<DropdownMenuItem<String>>(
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
                  iconEnabledColor: Colors.white,
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
