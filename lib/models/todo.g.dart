// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      title: fields[0] as String,
      totalUnits: fields[6] as int?,
      isGoal: fields[1] as bool,
      done: fields[3] as bool,
      progress: fields[2] as int,
      repeats: fields[4] as bool,
      repeatState: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isGoal)
      ..writeByte(2)
      ..write(obj.progress)
      ..writeByte(3)
      ..write(obj.done)
      ..writeByte(6)
      ..write(obj.totalUnits)
      ..writeByte(4)
      ..write(obj.repeats)
      ..writeByte(5)
      ..write(obj.repeatState);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
