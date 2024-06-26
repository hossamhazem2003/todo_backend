import 'package:todos_data_source/todos_data_source.dart';
import 'package:uuid/uuid.dart';

class InMemoryTodosDataSource implements TodosDataSource {
  final _cache = <String, Todo>{};

  /*
  {
     id : Todo()
    "1" : Todo1,
    "2" : Todo2,
    "3" : Todo3
  }
  */

  @override
  Future<Todo> create(Todo todo) async {
    final id = const Uuid().v4();
    final createdTodo = todo.copyWith(id: id);
    _cache[id] = createdTodo;
    return createdTodo;
  }

  @override
  Future<List<Todo>> readAll() async => _cache.values.toList();

  @override
  Future<Todo?> read(String id) async => _cache[id];

  @override
  Future<Todo> update(String id, Todo todo) async {
    return _cache.update(id, (value) => todo);
  }

  @override
  Future<void> delete(String id) async => _cache.remove(id);
}
