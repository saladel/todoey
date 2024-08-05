import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of tasks
  final CollectionReference taskTodo = FirebaseFirestore.instance.collection('tasks');

  // Create: add new task
  Future<void> addTask(String nameOfTask) {
    return taskTodo.add({
      'task': nameOfTask,
      'timestamp': DateTime.now(),
    });
  }

  // Read: get tasks from database
  Stream<QuerySnapshot> getTaskStream() {
    final taskStream = taskTodo.orderBy('timestamp', descending: false).snapshots();
    return taskStream;
  }

  // get number of tasks from database
  Stream<int> getTotalNumberOfTasks() {
    return taskTodo.snapshots().map((snapshot) => snapshot.docs.length);
  }

  // Update: edit a task
  Future<void> editATask(String taskId, String newTask) {
    return taskTodo.doc(taskId).update({
      'task': newTask,
      'timestamp': DateTime.now(),
    });
  }

  // Delete: delete a task
  Future<void> deleteTask(String taskId) {
    return taskTodo.doc(taskId).delete();
  }

//
}
