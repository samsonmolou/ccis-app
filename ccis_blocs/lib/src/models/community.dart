import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:meta/meta.dart';
import 'package:ccis_repository/ccis_repository.dart';

@immutable
class Community {
  final String id;
  final String name;

  Community({
    String id,
    String name = '',
    })
      : this.name = name ?? '',
        this.id = id ?? Uuid().generateV4();

  Community copyWith({
    String id,
    String name = ''}) {
    return Community(
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
        other is Community &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name
    ;
  }

  @override
  String toString() {
    return 'Community{id: $id, '
        'name: $name}';
  }

  CommunityEntity toEntity() {
    return CommunityEntity(id, name);
  }

  static Community fromEntity(CommunityEntity entity) {
    return Community(
        id: entity.id ?? Uuid().generateV4(),
        name: entity.name,
    );
  }
}