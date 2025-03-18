import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/user_cache.dart';
import '../../domain/usecase/sign_in_usecase.dart';
import '../../domain/usecase/sign_up_usecase.dart';
import '../../domain/usecase/update_fcm_token_usecase.dart';
import 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final UpdateFcmTokenUseCase updateFcmTokenUseCase;

  AuthCubit({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.updateFcmTokenUseCase,
  }) : super(AuthInitial());

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(email, password);
      final cache = UserCache();
      await cache.cacheUser(user);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> updateFcmToken(String uid) async {
    try {
      await updateFcmTokenUseCase(uid);
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }


  Future<void> loadCachedUser() async {
    final cache = UserCache();
    final cachedUser = await cache.getCachedUser();
    if (cachedUser != null) {
      print("Cached user found: ${cachedUser.uid}");
      emit(AuthSuccess(cachedUser));
    } else {
      print("No cached user found");
    }
  }

}
