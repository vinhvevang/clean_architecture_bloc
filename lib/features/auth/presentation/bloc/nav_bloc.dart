import 'package:bloc/bloc.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/nav_event.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState(0)) {
    on<ChangeTabEvent>((event, emit) => emit(NavState(event.index)));
  }
}
