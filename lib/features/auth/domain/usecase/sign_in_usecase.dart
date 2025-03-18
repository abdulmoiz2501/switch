import '../../data/models/user_model.dart';
import '../repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;
  SignInUseCase(this.repository);

  Future<UserModel> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
