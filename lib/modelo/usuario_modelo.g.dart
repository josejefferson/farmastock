// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_modelo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioModeloAdapter extends TypeAdapter<UsuarioModelo> {
  @override
  final int typeId = 1;

  @override
  UsuarioModelo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsuarioModelo(
      id: fields[0] as dynamic,
      nome: fields[1] as String,
      email: fields[2] as String,
      senha: fields[3] as String,
      role: fields[4] as UsuarioRole,
      cpf: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UsuarioModelo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.senha)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.cpf);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioModeloAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UsuarioRoleAdapter extends TypeAdapter<UsuarioRole> {
  @override
  final int typeId = 2;

  @override
  UsuarioRole read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UsuarioRole.admin;
      case 1:
        return UsuarioRole.user;
      default:
        return UsuarioRole.admin;
    }
  }

  @override
  void write(BinaryWriter writer, UsuarioRole obj) {
    switch (obj) {
      case UsuarioRole.admin:
        writer.writeByte(0);
        break;
      case UsuarioRole.user:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
