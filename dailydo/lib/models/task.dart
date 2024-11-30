import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  final String id;
  final String title;
  final bool isComplete;

  Task({required this.id, required this.title, this.isComplete = false});

  factory Task.fromDocument(DocumentSnapshot doc) {
    return Task(
      id: doc.id,
      title: doc['title'],
      isComplete: doc['isComplete'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title' : title,
      'isComplete' : isComplete,
    };
  }
}