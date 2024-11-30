import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;

  const TaskWidget({
    required this.task,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isComplete ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Wrap(
        children: [
          Checkbox(
            value: task.isComplete,
            onChanged: (_) => onToggleComplete(),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
