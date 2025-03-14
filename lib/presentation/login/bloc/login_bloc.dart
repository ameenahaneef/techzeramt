import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:techzeramt/data/models/user_model.dart';
import 'package:techzeramt/data/sources/shared_preference.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService = AuthService();
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    if (event.username.isNotEmpty && event.password.isNotEmpty) {
      final user =
          UserModel(username: event.username, password: event.password);

      final box = await Hive.openBox<UserModel>('userBox');
      await box.put('user', user);

      await _authService.saveLoginStatus(true);

      emit(LoginSuccess(user));
    } else {
      emit(LoginFailure('Invalid username or password'));
    }
  }

  void _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter<LoginState> emit) async {
    await _authService.logout(); 
    emit(LoginInitial()); 
  }
}
