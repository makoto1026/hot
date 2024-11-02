import 'package:flutter_sample/features/sample2/infrastructure/impl/sample_repository.dart';
import 'package:flutter_sample/features/sample2/infrastructure/sample_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sample_repository_provider.g.dart';

/// [SampleRepository]を取得します。
@riverpod
SampleRepository sampleRepository(Ref ref) {
  return ImplSampleRepository(ref);
}
