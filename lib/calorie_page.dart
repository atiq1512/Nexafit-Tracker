// pages/calorie_page.dart
import 'package:flutter/material.dart';

class CaloriePage extends StatefulWidget {
  @override
  _CaloriePageState createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  final TextEditingController foodController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  List<Map<String, dynamic>> meals = [];
  int totalCalories = 0;

  void addMeal() {
    final food = foodController.text;
    final cal = int.tryParse(caloriesController.text) ?? 0;
    if (food.isNotEmpty && cal > 0) {
      setState(() {
        meals.add({"food": food, "calories": cal});
        totalCalories += cal;
      });
      foodController.clear();
      caloriesController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      appBar: AppBar(
        title: Text("Calorie Tracker"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/7246/7246712.png',
              height: 120,
            ),
            SizedBox(height: 20),
            TextField(
              controller: foodController,
              decoration: InputDecoration(
                labelText: 'Food Item',
                prefixIcon: Icon(Icons.fastfood),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: caloriesController,
              decoration: InputDecoration(
                labelText: 'Calories',
                prefixIcon: Icon(Icons.local_fire_department),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: addMeal,
              icon: Icon(Icons.add),
              label: Text("Add Meal"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Total Calories: $totalCalories",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: meals.length,
                itemBuilder:
                    (context, index) => Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/1046/1046784.png',
                          width: 40,
                        ),
                        title: Text(
                          meals[index]['food'],
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Text(
                          "${meals[index]['calories']} cal",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
