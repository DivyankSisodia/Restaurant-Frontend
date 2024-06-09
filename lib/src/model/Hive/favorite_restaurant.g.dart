// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../favorite_restaurant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavRestaurantModelAdapter extends TypeAdapter<FavRestaurantModel> {
  @override
  final int typeId = 1;

  @override
  FavRestaurantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavRestaurantModel(
      id: fields[0] as String,
      title: fields[1] as String,
      imageUrl: fields[2] as String,
      rating: fields[3] as int,
      time: fields[4] as String,
      address: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavRestaurantModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavRestaurantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
