import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/v4.dart';

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

  Location update({
    required double latitude,
    required double longitude,
  }) {
    return copyWith(
      latitude: latitude,
      longitude: longitude,
      updatedAt: DateTime.now(),
    );
  }
}
