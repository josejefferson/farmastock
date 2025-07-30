import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

abstract class BaseModel {
  String id;

  BaseModel({String? id}) : id = id ?? _uuid.v4();

  Map<String, dynamic> toMap();
}
