import '../../data/models/user_model.dart';
import '../repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;
  SignUpUseCase(this.repository);

  Future<UserModel> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
