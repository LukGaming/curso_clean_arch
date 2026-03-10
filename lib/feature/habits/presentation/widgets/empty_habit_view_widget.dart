import 'package:flutter/material.dart';

class EmptyHabitViewWidget extends StatelessWidget {
  const EmptyHabitViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 80, color: Colors.deepPurple),
          SizedBox(height: 16),
          Text(
            "Nenhum hábito ainda",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text("Crie seu primeiro hábito"),
        ],
      ),
    );
  }
}
