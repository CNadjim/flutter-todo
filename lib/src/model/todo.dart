import 'package:uuid/uuid.dart';

enum TodoFilter { ALL, ACTIVE, COMPLETED }

class Todo {
  String id;
  String todo;
  bool completed;

  Todo({this.id, this.todo, this.completed});

  Todo.empty() {
    this.id = Uuid().v4();
    this.todo = "Swipez vers la gauche pour modifier la tâche";
    this.completed = false;
  }

  Todo copyWith({String id, bool completed, String todo}) {
    return Todo(
      id: id ?? this.id,
      completed: completed ?? this.completed,
      todo : todo ?? this.todo
    );
  }

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(id: json["id"], todo: json["todo"], completed: json["completed"]);
  }

  static List<Todo> fromJsonList(List<dynamic> json) => json.map((i) => fromJson(i)).toList();

  Map<String, dynamic> toJson() {
    return  {
      "todo": todo,
      "completed": completed,
      "id": id,
    };
  }

  @override
  String toString() => '{ id: $id, todo: $todo, completed: $completed}';
}


