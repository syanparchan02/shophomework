import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophomework/repository/api_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;

  LoginBloc(this.apiService) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      final token = await apiService.login(event.username, event.password);

      if (token != null) {
        emit(LoginSuccess(token));
      } else {
        emit(LoginFailure("Invalid username or password"));
      }
    });
  }
}
