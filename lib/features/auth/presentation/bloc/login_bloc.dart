import 'package:bloc/bloc.dart';
import 'package:bloc_nearly_complete/features/auth/domain/usecases/login.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/login_event.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;

  LoginBloc(this.login) : super(LoginInitial()) {
    on<LoginSubmitEvent>(_onSubmit);
    on<LogoutEvent>((_, emit) => emit(LoginInitial()));
  }

  void _onSubmit(LoginSubmitEvent event, Emitter<LoginState> emit) {
    String? taxError;
    String? usernameError;
    String? passwordError;

    // Validate từng field
    if (event.tax.isEmpty) {
      taxError = 'Không được để trống';
    } else if (int.tryParse(event.tax) == null) {
      taxError = 'Phải là số nguyên';
    }

    if (event.username.isEmpty) usernameError = 'Không được để trống';
    if (event.password.isEmpty) passwordError = 'Không được để trống';

    if (taxError != null || usernameError != null || passwordError != null) {
      emit(LoginFailure(
        taxError: taxError,
        usernameError: usernameError,
        passwordError: passwordError,
      ));
      return;
    }

    // Gọi use case
    final ok = login(int.parse(event.tax), event.username, event.password);

    if (ok) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(
        taxError: 'Sai thông tin đăng nhập',
        usernameError: 'Sai thông tin đăng nhập',
        passwordError: 'Sai thông tin đăng nhập',
      ));
    }
  }
}
