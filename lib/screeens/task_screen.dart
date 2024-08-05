import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoos/screeens/add_task_screen.dart';
import 'package:todoos/services/firestore.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({
    super.key,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool isChecked = false;
  final FirestoreService firestoreService = FirestoreService();

  List<bool> isCheckedList = [];

  Widget addTaskBottomSheet(BuildContext sheetContext) => const AddTaskScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      // FAB
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        enableFeedback: true,
        onPressed: () {
          showModalBottomSheet(context: context, builder: addTaskBottomSheet);
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blue top
          Container(
            padding: const EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 27,
                  child: Icon(
                    Icons.list_rounded,
                    color: Colors.lightBlue,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Todoey',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                  ),
                ),

                // Number of Tasks
                StreamBuilder(
                  stream: FirestoreService().getTotalNumberOfTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data} Tasks',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      );
                    } else {
                      return const Text(
                        'Getting the number of tasks you have',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),

          // white container
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getTaskStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> taskList = snapshot.data!.docs;

                    if (isCheckedList.length != taskList.length) {
                      isCheckedList = List<bool>.filled(taskList.length, false);
                    }

                    return ListView.builder(
                        itemCount: taskList.length,
                        itemBuilder: (context, index) {
                          // get each individual document
                          DocumentSnapshot taskDocument = taskList[index];
                          String taskDocumentId = taskDocument.id;

                          // get note from each doc
                          Map<String, dynamic> data = taskDocument.data() as Map<String, dynamic>;
                          String taskText = data['task'] ?? '';

                          // display as listTile
                          return ListTile(
                            // Checkbox
                            leading: Checkbox(
                              side: const BorderSide(color: Colors.lightBlue, width: 2),
                              checkColor: Colors.white,
                              tristate: false,
                              value: isCheckedList[index],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              activeColor: isCheckedList[index] ? Colors.grey : Colors.lightBlue,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedList[index] = value!;
                                });
                              },
                            ),

                            // Task Text
                            title: Text(
                              taskText,
                              style: TextStyle(
                                decoration: isCheckedList[index] ? TextDecoration.lineThrough : null,
                                color: isCheckedList[index] ? Colors.grey : Colors.black,
                              ),
                            ),

                            // Delete Button
                            trailing: IconButton(
                              onPressed: () {
                                firestoreService.deleteTask(taskDocumentId);
                              },
                              icon: Icon(
                                Icons.delete_forever,
                                color: isCheckedList[index] ? Colors.grey : Colors.lightBlue,
                                size: 20,
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: Text('No task on your todo'),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Edit Button
                                IconButton(
                                  onPressed: () {
                                    firestoreService.deleteTask(taskDocumentId);
                                  },
                                  icon: Icon(
                                    Icons.edit_note_rounded,
                                    color: isCheckedList[index] ? Colors.grey : Colors.lightBlue,
                                    size: 20,
                                  ),
                                ),
                                // Delete Button
                                IconButton(
                                  onPressed: () {
                                    firestoreService.deleteTask(taskDocumentId);
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: isCheckedList[index] ? Colors.grey : Colors.lightBlue,
                                    size: 20,
                                  ),
                                )
                              ],
                            )
 */
