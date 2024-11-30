import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String userId) {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId) 
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromDocument(doc)) 
            .toList()); 
  }

  Future<void> addTask(String userId, Task task) async {
    await _firestore.collection('tasks').add({
      'userId': userId,
      ...task.toMap(),
    });
  }

  Future<void> updateTask(String taskId, bool isComplete) async {
    await _firestore
        .collection('tasks')
        .doc(taskId)
        .update({'isComplete': isComplete}); 

  }


  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }

}
