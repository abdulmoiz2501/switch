import '../repository/auth_repository.dart';

class UpdateFcmTokenUseCase {
  final AuthRepository repository;
  UpdateFcmTokenUseCase(this.repository);

  Future<void> call(String uid) {
    return repository.updateFcmToken(uid);
  }
}
