import 'package:flutter/material.dart';
import 'package:simple_todo/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDoList = [
    ["learn flutter", false],
    ["learn react", false],
    ["learn django", true],
  ];

  void savedNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      appBar: AppBar(
        title: Text("simple todo"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      // Use SingleChildScrollView to allow scrolling when keyboard is visible
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom), // Padding to avoid keyboard overlap
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true, // Ensures list fits within the scrollable area
              physics:
                  NeverScrollableScrollPhysics(), // Prevent ListView from being scrollable independently
              itemCount: toDoList.length,
              itemBuilder: (BuildContext context, index) {
                return TodoList(
                  taskName: toDoList[index][0],
                  taskCompleted: toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
          ],
        ),
      ),
      // Keep bottomNavigationBar for the input field
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add new todo items',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: savedNewTask,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      // Enables the Scaffold to adjust when the keyboard appears
      resizeToAvoidBottomInset: true,
    );
  }
}
