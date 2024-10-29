import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample.freezed.dart';

part 'sample.g.dart';

/// サンプル情報です。
@freezed
class Sample with _$Sample {
  /// コンストラクタ
  const factory Sample({
    required String sampleId,
  }) = _Sample;

  /// JSONからSampleに変換します。
  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);
}
