import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/auth/service/auth_service.dart';

final trainerControllerProvider =
    StateNotifierProvider<MorrfTrainerNotifier, bool>(
  (ref) => MorrfTrainerNotifier(
    authService: ref.watch(authServiceProvider),
    ref: ref,
  ),
);

class MorrfTrainerNotifier extends StateNotifier<bool> {
  MorrfTrainerNotifier({required AuthService authService, required Ref ref})
      : super(false);

  Future _init() async {
    state = false;
  }
}
