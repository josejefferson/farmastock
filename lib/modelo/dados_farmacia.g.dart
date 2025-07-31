// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_farmacia.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DadosFarmaciaAdapter extends TypeAdapter<DadosFarmacia> {
  @override
  final int typeId = 3;

  @override
  DadosFarmacia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DadosFarmacia(
      id: fields[0] as String?,
      nomeFarmacia: fields[1] as String,
      cnpj: fields[2] as String,
      email: fields[3] as String?,
      telefone: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DadosFarmacia obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nomeFarmacia)
      ..writeByte(2)
      ..write(obj.cnpj)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.telefone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DadosFarmaciaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
