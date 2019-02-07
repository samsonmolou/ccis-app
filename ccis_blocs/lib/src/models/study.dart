import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';

@immutable
class Study {
  final String id;
  final String name;

  Study({
    String id,
    String name = '',
  })
      : this.name = name ?? '',
        this.id = id ?? Uuid().generateV4();

  Study copyWith({
    String id,
    String name = ''}) {
    return Study(
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
        other is Study &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name
    ;
  }

  @override
  String toString() {
    return 'Study{id: $id, '
        'name: $name}';
  }

  StudyEntity toEntity() {
    return StudyEntity(id, name);
  }

  static Study fromEntity(StudyEntity entity) {
    return Study(
      id: entity.id ?? Uuid().generateV4(),
      name: entity.name,
    );
  }
}