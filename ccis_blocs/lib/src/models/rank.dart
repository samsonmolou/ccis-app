import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';

@immutable
class Rank {
  final int value;

  Rank({
    int value,
  }) : this.value = value;

  Rank copyWith({int value}) {
    return Rank(
      value: value ?? this.value,
    );
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Rank &&
            runtimeType == other.runtimeType &&
            value == other.value;
  }

  @override
  String toString() {
    return 'Rank{value: $value}';
  }

  RankEntity toEntity() {
    return RankEntity(value);
  }

  static Rank fromEntity(RankEntity entity) {
    return Rank(
      value: entity.value,
    );
  }
}
