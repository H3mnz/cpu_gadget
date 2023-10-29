import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repositories.dart';

final isHoverProvider = StateProvider<bool>((ref) {
  return false;
});

final repositoryProvider = Provider<CpuRepository>((ref) {
  return CpuRepository();
});

final cpuUsageProvider = StreamProvider<double>((ref) {
  final repository = ref.watch(repositoryProvider);
  return repository.cpuUsageStream();
});
