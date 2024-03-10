import 'package:flutter/material.dart';

class RegisterDoctorPage extends StatefulWidget {
  @override
  _RegisterDoctorPageState createState() => _RegisterDoctorPageState();
}

class _RegisterDoctorPageState extends State<RegisterDoctorPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Doctor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add logic to save username and password
                String username = _usernameController.text;
                String password = _passwordController.text;
                // You can add further logic here like validation, saving to database, etc.
                print('Username: $username');
                print('Password: $password');
                // You can navigate to the next page or do anything else after registration
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}


