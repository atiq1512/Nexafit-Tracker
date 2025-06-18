import 'package:flutter/material.dart';
import 'timer_page.dart';
import 'saved_details_page.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String email;
  final String goal;

  const HomePage({required this.name, required this.email, required this.goal});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> savedActivities = [];

  void navigateToTimer(String activity) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TimerPage(activity: activity)),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        savedActivities.add(result);
      });
    }
  }

  void navigateToSavedDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SavedDetailsPage(
              savedActivities: savedActivities,
              savedMeals: [],
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text("Nexafit Tracker"),
        centerTitle: true,
        backgroundColor: Color(0xFF667EEA),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Welcome, ${widget.name}!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Goal: ${widget.goal}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 30),

            // Tools Section
            Text(
              "Tools",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundToolButton(
                  icon: Icons.monitor_weight,
                  label: "BMI",
                  color: Color(0xFF667EEA),
                  onTap: () => Navigator.pushNamed(context, '/bmi'),
                ),
                _buildRoundToolButton(
                  icon: Icons.local_fire_department,
                  label: "Calories",
                  color: Color(0xFF667EEA),
                  onTap: () => Navigator.pushNamed(context, '/calories'),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Workout Section
            Text(
              "Workout Activities",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),

            _buildActivityButton(
              "Running",
              Icons.directions_run,
              Colors.purpleAccent,
            ),
            _buildActivityButton("Cycling", Icons.directions_bike, Colors.cyan),
            _buildActivityButton(
              "Sprinting",
              Icons.flash_on,
              Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 13, 13, 13), // Dark background
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.name,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            accountEmail: Text(
              widget.email,
              style: TextStyle(color: Colors.white70),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Color(0xFF667EEA)),
            ),
            decoration: BoxDecoration(color: Color(0xFF667EEA)),
          ),
          ListTile(
            leading: Icon(Icons.fitness_center, color: Colors.white),
            title: Text(
              "Fitness Goal: ${widget.goal}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.white),
            title: Text("Saved Details", style: TextStyle(color: Colors.white)),
            onTap: navigateToSavedDetails,
          ),
          Spacer(),
          Divider(color: Colors.grey.shade700),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityButton(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () => navigateToTimer(label),
        child: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 36, 36, 36),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            border: Border.all(color: Colors.grey.shade400, width: 2),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10),
                child: Icon(icon, color: color),
              ),
              SizedBox(width: 20),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundToolButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(60),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 26,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
