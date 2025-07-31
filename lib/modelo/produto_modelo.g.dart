// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_modelo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProdutoAdapter extends TypeAdapter<Produto> {
  @override
  final int typeId = 4;

  @override
  Produto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Produto(
      id: fields[0] as dynamic,
      nome: fields[1] as String,
      codigoBarras: fields[2] as String?,
      unidadeMedida: fields[3] as UnidadeMedida,
      quantidadeAtual: fields[4] as int,
      quantidadeMinima: fields[5] as int,
      precoCusto: fields[6] as double,
      precoVenda: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Produto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.codigoBarras)
      ..writeByte(3)
      ..write(obj.unidadeMedida)
      ..writeByte(4)
      ..write(obj.quantidadeAtual)
      ..writeByte(5)
      ..write(obj.quantidadeMinima)
      ..writeByte(6)
      ..write(obj.precoCusto)
      ..writeByte(7)
      ..write(obj.precoVenda);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProdutoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UnidadeMedidaAdapter extends TypeAdapter<UnidadeMedida> {
  @override
  final int typeId = 5;

  @override
  UnidadeMedida read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UnidadeMedida.mg;
      case 1:
        return UnidadeMedida.g;
      case 2:
        return UnidadeMedida.kg;
      case 3:
        return UnidadeMedida.mL;
      case 4:
        return UnidadeMedida.L;
      case 5:
        return UnidadeMedida.un;
      default:
        return UnidadeMedida.mg;
    }
  }

  @override
  void write(BinaryWriter writer, UnidadeMedida obj) {
    switch (obj) {
      case UnidadeMedida.mg:
        writer.writeByte(0);
        break;
      case UnidadeMedida.g:
        writer.writeByte(1);
        break;
      case UnidadeMedida.kg:
        writer.writeByte(2);
        break;
      case UnidadeMedida.mL:
        writer.writeByte(3);
        break;
      case UnidadeMedida.L:
        writer.writeByte(4);
        break;
      case UnidadeMedida.un:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnidadeMedidaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
