import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool obsecureText = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late SharedPreferences sharedPreferences;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    newUser = (sharedPreferences.getBool('login') ?? true);
    print(newUser);
    if (newUser == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  String calculateSHA256(String input) {
    var bytes = utf8.encode(input); // Encode the input string as UTF-8
    var digest = sha256.convert(bytes); // Calculate the SHA-256 hash
    return digest.toString(); // Convert the hash to a string
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Colors.pinkAccent[100]
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.pinkAccent[100]!
                          ),
                      ),
                      labelText: 'Username',
                      hintText: 'Enter your Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    cursorColor: Colors.pinkAccent[100],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: obsecureText,
                    decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(
                            color: Colors.pinkAccent[100]
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.pinkAccent[100]!
                          )
                        ),
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obsecureText = !obsecureText;
                              });
                            },
                            icon: Icon(
                              obsecureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[600],
                            )),
                        contentPadding: EdgeInsets.symmetric(vertical: 15)
                    ),
                    cursorColor: Colors.pinkAccent[100],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      sharedPreferences.setBool('login', false);
                      sharedPreferences.setString('username', _usernameController.text);

                      String enteredPasswordHash = calculateSHA256(_passwordController.text);
                      String storedPasswordHash = calculateSHA256('admin');

                      if (_usernameController.text == 'admin' && _passwordController.text == 'admin') {

                        if (enteredPasswordHash == storedPasswordHash) {
                          print('Entered Password Hash: $enteredPasswordHash');
                          print('Stored Password Hash: $storedPasswordHash');
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage())
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Login Success'),
                                backgroundColor: Colors.green,
                              )
                          );
                        }
                      } else {
                        print('Entered Password Hash: $enteredPasswordHash');
                        print('Stored Password Hash: $storedPasswordHash');
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login Failed'),
                              backgroundColor: Colors.red,
                            )
                        );
                      }
                    },
                    child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
