import 'package:flutter/material.dart';
import 'package:myflutterproject/screens/doctor/doctor_home_page.dart';
import 'package:myflutterproject/screens/admin/admin_home.dart';

// import 'sign_up_screen.dart'; // Ensure this path is correct

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Username and password for Doctor
    if (_emailController.text == 'dr doctor' && _passwordController.text == 'doctor') {
      Navigator.pushReplacement( // Use pushReplacement to prevent going back to the login page
        context,
        MaterialPageRoute(builder: (context) => DoctorHomePage()),
      );
    }
    // Username and password for Admin
    else if (_emailController.text == 'admin' && _passwordController.text == 'gokul') {
      Navigator.pushReplacement( // Use pushReplacement to prevent going back to the login page
        context,
        MaterialPageRoute(builder: (context) => AdminUser()),
      );
    } else {
      // Show an error message if credentials don't match
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid username or password'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'username',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login, // Call the _login method here
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
