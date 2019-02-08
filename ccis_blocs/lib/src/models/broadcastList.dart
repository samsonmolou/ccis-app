import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';

@immutable
class BroadcastList {
  final String id;
  final String name;

  BroadcastList({
    String id,
    String name = '',
  })
      : this.name = name ?? '',
        this.id = id ?? Uuid().generateV4();

  BroadcastList copyWith({
    String id,
    String name = ''}) {
    return BroadcastList(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BroadcastList &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name
    ;
  }

  @override
  String toString() {
    return 'BroadcastList{id: $id, '
        'name: $name}';
  }

  BroadcastListEntity toEntity() {
    return BroadcastListEntity(id, name);
  }

  static BroadcastList fromEntity(BroadcastListEntity entity) {
    return BroadcastList(
      id: entity.id ?? Uuid().generateV4(),
      name: entity.name,
    );
  }
}