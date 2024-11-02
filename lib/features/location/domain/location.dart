import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';

part 'location.g.dart';

/// サンプル情報です。
@freezed
class Location with _$Location {
  /// コンストラクタ
  const factory Location({
    required String id,
    required double latitude,
    required double longitude,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String userId,
  }) = _Location;

  /// JSONからLocationに変換します。
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
