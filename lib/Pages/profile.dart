import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'convert.dart';
import 'feedback.dart';
import 'home.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int _currentIndex = 3;
  final List<Widget> _screens = [
    HomePage(),
    Convert(),
    FeedbackForm(),
    ProfilePage(),
  ];

  Future<void> _logout() async {
    // Clear the username from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('login');

    // Navigate to the login page and remove the previous routes from the stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Profile Page',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[600],
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 450,
            width: 400,
            child: Card(
              color: Colors.blueGrey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/foto.jpg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          launcher('https://www.instagram.com/ridho_contrisha/');
                        },
                        icon: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/2048px-Instagram_logo_2022.svg.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          launcher('https://github.com/rcontrisha');
                        },
                        icon: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/GitHub_Invertocat_Logo.svg/1200px-GitHub_Invertocat_Logo.svg.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Ridho Contrisha',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Text(
                    '124210022',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    'Tangerang, 27 Juni 2003',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal[700],
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Convert()),
            );
          } if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FeedbackForm()),
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
              backgroundColor: Colors.pinkAccent[100]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.autorenew_rounded),
              label: 'Konversi',
              backgroundColor: Colors.pinkAccent[100]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined),
              label: 'Feedback',
              backgroundColor: Colors.pinkAccent[100]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
              backgroundColor: Colors.pinkAccent[100]
          ),
        ],
      ),
    );
  }

  Future<void> launcher(String url) async {
    final Uri _url = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (!await launchUrl(_url)) {
      throw Exception("Failed to launch URL: $_url");
    }
  }
}
