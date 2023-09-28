import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/providers/todo_provider.dart';

class AddNewTask extends ConsumerStatefulWidget {
  const AddNewTask({super.key});

  @override
  ConsumerState<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends ConsumerState<AddNewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 234, 234),
        appBar: AppBar(
          title: const Text(
            "Add New Task",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Task Title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Color.fromARGB(26, 61, 60, 60)),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: dateController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(26, 61, 60, 60)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          const Text(
                            "Time",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: timeController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(26, 61, 60, 60)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 10), child: Text("Notes")),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 300,
                  child: TextField(
                    controller: descriptionController,
                    expands: true,
                    maxLines: null,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(26, 61, 60, 60),
                        isDense: true),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    // Task newTask = Task(
                    //     type: tasktype,
                    //     title: titleController.text,
                    //     description: descriptionController.text,
                    //     isComplate: false);
                    ref.read(todoProvider.notifier).state = [
                      ...?ref.read(todoProvider.notifier).state,
                      Todo(
                        id: Random().nextInt(10000),
                        todo: descriptionController.text,
                        completed: false,
                        userId: Random().nextInt(1000),
                      ),
                    ];

                    Navigator.pop(context);
                  },
                  child: const Text("SAVE"))
            ],
          ),
        ),
      ),
    );
  }
}
