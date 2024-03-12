import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:medicalapp1/components/MYAppBar.dart';

class LoginPage extends StatelessWidget {
  final Logger logger = Logger();

  // Hardcoded username and password for demonstration purposes
  final String validUsername = 'isira';
  final String validPassword = 'isira';

  void _login(BuildContext context,String username, String password) {
    if (username == validUsername && password == validPassword) {
      logger.i('Login successful for username: $username');
      // Navigate to the next screen upon successful login
      // For demonstration, let's just print a message
      _showSnackBar(context,"Login successfully",Colors.green);
      Navigator.pushNamed(context, "/home");
      print('Login successful!');
    } else {
      _showSnackBar(context,"Invalid username or password",Colors.red);
      logger.e('Login failed for username: $username');

      // Display error message to the user
      // For demonstration, let's just print a message
      print('Login failed. Invalid username or password.');
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent, // Set background color to transparent
        elevation: 0, // Remove shadow
        content: Card(// Wrap content in a Card
          shape: RoundedRectangleBorder( // Apply rounded border
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    String password = '';

    return Scaffold(
      appBar: MyAppBar("Login page"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900]
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                username = value;
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _login(context, username, password);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                backgroundColor: Colors.lightBlue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),  // Set your desired border radius here
                ),// Set your desired padding here
              ),
              child: Text('Login',
                          style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900]
                        ),),


            ),
          ],
        ),
      ),
    );
  }
}