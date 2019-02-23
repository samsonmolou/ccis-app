import 'package:ccis_blocs/src/helpers/uuid.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';


@immutable
class Broadcast {
  final String id;
  final int rank;
  final String broadcastListId;
  final String message;
  //TODO: Bug on dateTime, every time, we reload app, it's value change
  /// Don't know how to solve it, so i'm going forward to be on time, i will
  /// i will come back later to solve it
  final String dateTime;
  final String name;

  //TODO: make field required
  Broadcast(
      {String id,
      int rank,
      String broadcastListId = '',
      String message = '',
      @required String dateTime,
      String name = ''})
      : this.rank = rank,
        this.broadcastListId = broadcastListId ?? '',
        this.message = message ?? '',
        this.dateTime = dateTime,
        this.name = name ?? '',
        this.id = id ?? Uuid().generateV4();

  Broadcast copyWith(
      {String id,
      int rank,
      String broadcastListId,
      String message,
      String dateTime,
      String name}) {
    return Broadcast(
        id: id ?? this.id,
        rank: rank ?? this.rank,
        broadcastListId: broadcastListId ?? this.broadcastListId,
        message: message ?? this.message,
        dateTime: dateTime ?? this.dateTime,
        name: name ?? this.name);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rank.hashCode ^
        broadcastListId.hashCode ^
        message.hashCode ^
        dateTime.hashCode ^
        name.hashCode;
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
            dateTime == other.dateTime &&
            name == other.name;
  }

  @override
  String toString() {
    return 'Broadcast{id: $id, '
        'rank: $rank'
        'broadcastListId: $broadcastListId'
        'message: $message'
        'dateTime: $dateTime}';
  }

  BroadcastEntity toEntity() {
    return BroadcastEntity(id, rank, broadcastListId, message, dateTime, name);
  }

  static Broadcast fromEntity(BroadcastEntity entity) {
    final broadcast = Broadcast(
        id: entity.id ?? Uuid().generateV4(),
        rank: entity.rank,
        broadcastListId: entity.broadcastListId,
        message: entity.message,
        dateTime: entity.dateTime,
        name: entity.name);

    return broadcast;
  }
}
