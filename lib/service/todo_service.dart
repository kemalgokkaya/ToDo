import 'dart:convert';
import 'package:todo/model/todo.dart';
import 'package:http/http.dart' as http;

class TodoService {
  final String url = "https://dummyjson.com/todos";

  Future<({List<Todo> uncompleted, List<Todo> completed})>
      getTodos() async {
    final response = await http.get(Uri.parse(url));
    List<dynamic> resp = jsonDecode(response.body)["todos"];

    List<Todo> uncompleted = List.empty(growable: true);
    List<Todo> completedTodos = List.empty(growable: true);

    for (var element in resp) {
      Todo task = Todo.fromJson(element);
      if (task.completed == false) {
        uncompleted.add(task);
      } else {
        completedTodos.add(task);
      }
    }
    return (uncompleted: uncompleted, completed: completedTodos);
  }
}
