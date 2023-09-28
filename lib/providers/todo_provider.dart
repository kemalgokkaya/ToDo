import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/service/todo_service.dart';

final todoFutureProvider = FutureProvider<({List<Todo> uncompleted, List<Todo> completed})>((ref) async {
  TodoService service = TodoService();
  return await service.getTodos();
});

final todoProvider = StateProvider<List<Todo>?>((ref) {
  var provider = ref.watch(todoFutureProvider);
  return provider.valueOrNull?.uncompleted;
});

final completedTodoProvider = StateProvider<List<Todo>?>((ref) {
  var provider = ref.watch(todoFutureProvider);
  return provider.valueOrNull?.completed;
});
