import 'package:flutter_sample/features/sample2/domain/sample.dart';
import 'package:flutter_sample/features/sample2/infrastructure/sample_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// [SampleRepository]です。
class ImplSampleRepository implements SampleRepository {
  /// コンストラクタ
  ImplSampleRepository(this._ref);

  final Ref _ref;

  @override
  Future<Sample> fetchSamples() async {
    const res = Sample(sampleId: '');

    return res;
  }
}
