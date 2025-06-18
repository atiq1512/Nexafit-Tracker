import 'package:flutter/material.dart';

class SavedDetailsPage extends StatelessWidget {
  final List<Map<String, dynamic>> savedActivities;

  const SavedDetailsPage({
    required this.savedActivities,
    required List<Map<String, dynamic>> savedMeals,
  });

  @override
  Widget build(BuildContext context) {
    double totalDistance = savedActivities.fold(
      0.0,
      (sum, activity) => sum + (activity['distance'] as double),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      appBar: AppBar(
        title: Text("Saved Activities"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Total Distance: ${totalDistance.toStringAsFixed(2)} km",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: savedActivities.length,
                itemBuilder: (context, index) {
                  final activity = savedActivities[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.fitness_center, color: Colors.green),
                      title: Text(
                        activity['activity'],
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text("Duration: ${activity['duration']}"),
                      trailing: Text(
                        "${activity['distance']} km",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
