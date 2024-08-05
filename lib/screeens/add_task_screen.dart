import 'package:flutter/material.dart';
import 'package:todoos/services/firestore.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController taskToAddText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          // Add Task & Dismiss Icon Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              const Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 25,
                ),
              ),

              // gives space between the asdd task text and x button
              const Expanded(
                child: SizedBox(),
              ),

              // X button
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 15, bottom: 20),
                child: CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded),
                    iconSize: 25,
                    color: Colors.lightBlueAccent,
                    enableFeedback: true,
                  ),
                ),
              ),
            ],
          ),

          // Task Textfield & Add button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Column(
                children: [
                  // Textfield
                  TextField(
                    controller: taskToAddText,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.lightBlueAccent,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'I want to...',
                      hintText: "What do you want to do today?",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[400],
                        fontSize: 15,
                      ),
                    ),
                  ),

                  // Add Button
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: MaterialButton(
                      elevation: 7.5,
                      onPressed: () {
                        // adds a new task
                        FirestoreService().addTask(taskToAddText.text);

                        // cloeses the bottomsheet
                        Navigator.pop(context);
                      },
                      color: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      //shape: const StadiumBorder(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      minWidth: 200,
                      height: 40,
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
caffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close_rounded,
          ),
          iconSize: 30,
        ),
      ),
    )
 */
