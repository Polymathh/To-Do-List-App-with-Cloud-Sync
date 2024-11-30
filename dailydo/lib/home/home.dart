import 'package:flutter/material.dart';

import 'package:dailydo/home/task_widget.dart';
import '../models/task.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final userId = "example_user_id"; // Replace with actual user ID
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: StreamBuilder<List<Task>>(
        stream: _firestoreService.getTasks(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found.'));
          }
          return ListView(
            children: snapshot.data!.map((task) {
              return TaskWidget(
                task: task,
                onToggleComplete: () =>
                    _firestoreService.updateTask(task.id, !task.isComplete),
                onDelete: () => _firestoreService.deleteTask(task.id),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, userId),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, String userId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _firestoreService.addTask(
                userId,
                Task(id: '', title: controller.text),
              );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
