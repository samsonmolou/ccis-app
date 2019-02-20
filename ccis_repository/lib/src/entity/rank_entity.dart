class RankEntity {
  final int value;

  RankEntity(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RankEntity &&
              runtimeType == other.runtimeType &&
              value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Rank{value: $value}';
  }

  static RankEntity fromJson(Map<String, Object> json) {
    return RankEntity(
        json["value"] as int
    );
  }

  Map<String, Object> toJson() {
    return {
      "value": value,
    };
  }
}