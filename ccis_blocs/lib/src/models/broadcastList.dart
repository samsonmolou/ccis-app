import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';

@immutable
class BroadcastList {
  final String id;
  final String name;
  final List<String> membersId;

  //TODO: make name and membersId required
  BroadcastList({
    String id,
    String name = '',
    membersId
  })
      : this.name = name ?? '',
        this.membersId = membersId ?? List<String>(),
        this.id = id ?? Uuid().generateV4();

  BroadcastList copyWith({
    String id,
    String name = '',
    List<String> membersId}) {
    return BroadcastList(
      id: id ?? this.id,
      name: name ?? this.name,
      membersId: membersId ?? this.membersId
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ membersId.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BroadcastList &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            membersId == other.membersId
    ;
  }

  @override
  String toString() {
    return 'BroadcastList{id: $id, '
        'name: $name}'
        'membersId: $membersId';
  }

  BroadcastListEntity toEntity() {
    return BroadcastListEntity(id, name, membersId);
  }

  static BroadcastList fromEntity(BroadcastListEntity entity) {
    return BroadcastList(
      id: entity.id ?? Uuid().generateV4(),
      name: entity.name,
      membersId: entity.membersId
    );
  }
}