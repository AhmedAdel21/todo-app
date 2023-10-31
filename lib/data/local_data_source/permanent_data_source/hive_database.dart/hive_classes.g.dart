// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_classes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoTaskHiveAdapter extends TypeAdapter<TodoTaskHive> {
  @override
  final int typeId = 0;

  @override
  TodoTaskHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoTaskHive(
      id: fields[0] as String,
      icon: fields[1] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      dateTime: fields[4] as DateTime,
      isDone: fields[5] as bool,
      hour: fields[6] as int,
      minute: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TodoTaskHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.isDone)
      ..writeByte(6)
      ..write(obj.hour)
      ..writeByte(7)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoTaskHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TodoTasksHiveWrapperAdapter extends TypeAdapter<TodoTasksHiveWrapper> {
  @override
  final int typeId = 1;

  @override
  TodoTasksHiveWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoTasksHiveWrapper()
      ..todoTask = (fields[0] as Map).cast<String, TodoTaskHive>();
  }

  @override
  void write(BinaryWriter writer, TodoTasksHiveWrapper obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.todoTask);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoTasksHiveWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
