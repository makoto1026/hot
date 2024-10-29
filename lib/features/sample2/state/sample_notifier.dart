import 'package:flutter_sample/features/sample2/domain/sample.dart';
import 'package:flutter_sample/features/sample2/infrastructure/sample_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sample_notifier.g.dart';

/// サンプルNotifierです。
@riverpod
class SampleNotifier extends _$SampleNotifier {
  @override
  Future<Sample> build() async {
    final _ = ref.watch(sampleRepositoryProvider);

    return const Sample(
      sampleId: '',
    );
  }
}
