import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/screens/add_new_task.dart';
import 'package:todo/todoitem.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    List<Todo>? todoState = ref.watch(todoProvider);
    List<Todo>? completedTodoState = ref.watch(completedTodoProvider);

    var height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddNewTask(),
              ),
            );
          },
          child: const Text("Add New Task"),
        ),
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: height / 8,
          title: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${now.day}.${now.month}.${now.year}"),
                const Text(
                  "TO DO LIST",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: ListView.builder(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todoState?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TodoItem(
                      task: todoState![index],
                    );
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "COMPLETE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                itemCount: completedTodoState?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            completedTodoState![index].todo ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: completedTodoState[index].completed,
                          onChanged: (val) {
                            ref.read(todoProvider.notifier).state = [
                              ...?todoState,
                              Todo(
                                id: completedTodoState[index].id,
                                todo: completedTodoState[index].todo,
                                completed: false,
                                userId: completedTodoState[index].userId,
                              ),
                            ];
                            ref.read(completedTodoProvider.notifier).state = [
                              ...completedTodoState.sublist(0, index),
                              ...completedTodoState.sublist(index + 1),
                            ];
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
