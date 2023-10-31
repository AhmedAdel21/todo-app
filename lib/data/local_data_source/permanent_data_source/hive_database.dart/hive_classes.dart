import 'package:hive/hive.dart';
part 'hive_classes.g.dart';

@HiveType(typeId: 0)
class TodoTaskHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String icon;

  @HiveField(2)
  String name;

  @HiveField(3)
  String description;

  @HiveField(4)
  DateTime dateTime;

  @HiveField(5)
  bool isDone;

  @HiveField(6)
  int hour;

  @HiveField(7)
  int minute;

  TodoTaskHive({
    required this.id,
    required this.icon,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.isDone,
    required this.hour,
    required this.minute,
  });
  Map<String, dynamic> get toMap => {
        "id": id,
        "icon": icon,
        "name": name,
        "description": description,
        "dateTime": dateTime,
        "isDone": isDone,
        "hour": hour,
        "minute": minute,
      };

  @override
  String toString() =>
      "TodoTaskHive(id:$id, icon: $icon, name: $name, description: $description, dateTime: $dateTime, isDone: $isDone, hour: $hour, minute: $minute)";
}

@HiveType(typeId: 1)
class TodoTasksHiveWrapper extends HiveObject {
  @HiveField(0)
  Map<String, TodoTaskHive> todoTask = {};

  Future<void> addNewTask(TodoTaskHive newTask) async {
    todoTask.addAll({newTask.id: newTask});
    await save();
  }

  Future<TodoTaskHive?> removeTask(String id) async {
    final removedItem = todoTask.remove(id);
    await save();
    return removedItem;
  }

  Future<TodoTaskHive?> setTaskState(String hiveTaskId, bool newState) async {
    todoTask[hiveTaskId]?.isDone = newState;
    await save();
    return todoTask[hiveTaskId];
  }
}
