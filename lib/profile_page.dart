import 'package:flutter/material.dart';
import 'home_page.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String goal;

  const ProfilePage({
    required this.name,
    required this.email,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      appBar: AppBar(title: Text('Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle, size: 100, color: Colors.blueAccent),
              SizedBox(height: 20),
              Text(
                'Name: $name',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                'Fitness Goal: $goal',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => HomePage(name: name, email: email, goal: goal),
                    ),
                  );
                },
                child: Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
