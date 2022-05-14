// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moneymanagermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class categoryModelAdapter extends TypeAdapter<categoryModel> {
  @override
  final int typeId = 1;

  @override
  categoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return categoryModel(
      categoryName: fields[1] as String,
      categoryType: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, categoryModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categoryType)
      ..writeByte(1)
      ..write(obj.categoryName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is categoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class addExpAndIncModelAdapter extends TypeAdapter<addExpAndIncModel> {
  @override
  final int typeId = 2;

  @override
  addExpAndIncModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return addExpAndIncModel(
      categoryName: fields[2] as dynamic,
      amount: fields[3] as int,
      dateOftransaction: fields[1] as DateTime,
      transactionType: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, addExpAndIncModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.transactionType)
      ..writeByte(1)
      ..write(obj.dateOftransaction)
      ..writeByte(2)
      ..write(obj.categoryName)
      ..writeByte(3)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is addExpAndIncModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
