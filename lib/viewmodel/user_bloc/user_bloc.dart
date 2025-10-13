import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophomework/repository/api_service.dart';
import 'package:shophomework/viewmodel/user_bloc/user_even.dart';
import 'package:shophomework/viewmodel/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiService apiService = ApiService();

  UserBloc(this.apiService) : super(UserInitialState()) {
    on<ULoadEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        var userList = await apiService.getUsers();
        emit(UserLoadedState(userList));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
