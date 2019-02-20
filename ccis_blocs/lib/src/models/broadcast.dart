import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';

@immutable
class Broadcast {
  final String id;
  final int rank;
  final String broadcastListId;
  final String message;
  final String dateHeure;

  //TODO: make field required
  Broadcast(
      {String id,
      int rank,
      String broadcastListId = '',
      String message = '',
      String dateHeure = ''})
      : this.rank = rank,
        this.broadcastListId = broadcastListId ?? '',
        this.message = message ?? '',
        this.dateHeure = dateHeure ?? DateTime.now().toString(),
        this.id = id ?? Uuid().generateV4();

  Broadcast copyWith(
      {String id,
      int rank,
      String broadcastListId,
      String message,
      String dateHeure}) {
    return Broadcast(
        id: id ?? this.id,
        rank: rank ?? this.rank,
        broadcastListId: broadcastListId ?? this.broadcastListId,
        message: message ?? this.message,
        dateHeure: dateHeure ?? this.dateHeure);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rank.hashCode ^
        broadcastListId.hashCode ^
        message.hashCode ^
        dateHeure.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Broadcast &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            rank == other.rank &&
            broadcastListId == other.broadcastListId &&
            message == other.message &&
            dateHeure == other.dateHeure;
  }

  @override
  String toString() {
    return 'Broadcast{id: $id, '
        'rank: $rank'
        'broadcastListId: $broadcastListId'
        'message: $message'
        'dateHeure: $dateHeure}';
  }

  BroadcastEntity toEntity() {
    return BroadcastEntity(id, rank, broadcastListId, message, dateHeure);
  }

  static Broadcast fromEntity(BroadcastEntity entity) {
    final broadcast = Broadcast(
        id: entity.id ?? Uuid().generateV4(),
        rank: entity.rank,
        broadcastListId: entity.broadcastListId,
        message: entity.message,
        dateHeure: entity.dateHeure
    );

    return broadcast;
  }
}
