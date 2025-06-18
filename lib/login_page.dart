import 'package:flutter/material.dart';
import 'profile_page.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  final _nameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedGoal;
  String? registeredName;
  String? registeredEmail;
  String? registeredPassword;
  String? registeredGoal;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _nameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  void _login() {
    if (_loginFormKey.currentState!.validate()) {
      if (_loginEmailController.text == registeredEmail &&
          _loginPasswordController.text == registeredPassword) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => ProfilePage(
                  name: registeredName!,
                  email: registeredEmail!,
                  goal: registeredGoal!,
                ),
          ),
        );
      } else {
        _showErrorDialog("Incorrect email or password.");
      }
    }
  }

  void _register() {
    if (_registerFormKey.currentState!.validate()) {
      if (_signupPasswordController.text != _confirmPasswordController.text) {
        _showErrorDialog("Passwords do not match.");
        return;
      }

      registeredName = _nameController.text;
      registeredEmail = _signupEmailController.text;
      registeredPassword = _signupPasswordController.text;
      registeredGoal = _selectedGoal ?? 'Not specified';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => ProfilePage(
                name: registeredName!,
                email: registeredEmail!,
                goal: registeredGoal!,
              ),
        ),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Color(0xFF667EEA)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF667EEA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF667EEA), width: 2),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.fitness_center, size: 64, color: Color(0xFF667EEA)),
              SizedBox(height: 8),
              Text(
                'Welcome to Nexafit Tracker !',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              TabBar(
                controller: _tabController,
                indicatorColor: Color(0xFF667EEA),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: const [Tab(text: "Login"), Tab(text: "Sign Up")],
              ),
              SizedBox(
                height: 500,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          _buildTextField(
                            label: 'Email',
                            icon: Icons.email,
                            controller: _loginEmailController,
                          ),
                          SizedBox(height: 16),
                          _buildTextField(
                            label: 'Password',
                            icon: Icons.lock,
                            controller: _loginPasswordController,
                            obscure: true,
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF667EEA),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Login'),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          _buildTextField(
                            label: 'Full Name',
                            icon: Icons.person,
                            controller: _nameController,
                          ),
                          SizedBox(height: 16),
                          _buildTextField(
                            label: 'Email',
                            icon: Icons.email,
                            controller: _signupEmailController,
                          ),
                          SizedBox(height: 16),
                          _buildTextField(
                            label: 'Password',
                            icon: Icons.lock,
                            controller: _signupPasswordController,
                            obscure: true,
                          ),
                          SizedBox(height: 16),
                          _buildTextField(
                            label: 'Confirm Password',
                            icon: Icons.lock_outline,
                            controller: _confirmPasswordController,
                            obscure: true,
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            dropdownColor: Colors.grey[800],
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Fitness Goal',
                              labelStyle: TextStyle(color: Colors.white70),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF667EEA),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF667EEA),
                                ),
                              ),
                            ),
                            items:
                                [
                                      'Lose weight',
                                      'Build muscle',
                                      'Endurance',
                                      'Wellness',
                                    ]
                                    .map(
                                      (goal) => DropdownMenuItem(
                                        value: goal,
                                        child: Text(goal),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (value) =>
                                    setState(() => _selectedGoal = value),
                            validator:
                                (value) =>
                                    value == null
                                        ? 'Please select a goal'
                                        : null,
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF667EEA),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
