import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/model/todo.dart';

class TodoItem extends ConsumerStatefulWidget {
  const TodoItem({super.key, required this.task});
  final Todo task;

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  bool ischeced = false;
  @override
  Widget build(BuildContext context) {
    List<Todo>? todoController = ref.read(todoProvider.notifier).state;

    return Column(
      children: [
        Card(
          color: widget.task.completed == true ? Colors.grey : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.task.todo!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        "User${widget.task.userId}",
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  value: ischeced,
                  onChanged: (val) {
                    ref.read(completedTodoProvider.notifier).state = [
                      ...?ref.read(completedTodoProvider.notifier).state,
                      Todo(
                        id: widget.task.id,
                        todo: widget.task.todo,
                        completed: true,
                        userId: widget.task.userId,
                      )
                    ];
                    ref.read(todoProvider.notifier).state = [
                      ...todoController!.sublist(
                        0,
                        todoController.indexWhere(
                            (element) => element.id == widget.task.id),
                      ),
                      ...todoController.sublist(todoController.indexWhere(
                              (element) => element.id == widget.task.id) +
                          1),
                    ];
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
