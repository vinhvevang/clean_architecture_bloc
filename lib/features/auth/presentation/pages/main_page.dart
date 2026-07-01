import 'package:bloc_nearly_complete/features/auth/presentation/bloc/nav_bloc.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/nav_event.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/nav_state.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/pages/account_page.dart';
import 'package:bloc_nearly_complete/features/product/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // NavBloc cấp tại MainPage → tự reset mỗi lần đăng nhập lại
    return BlocProvider(
      create: (_) => NavBloc(),
      child: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.index,
              children: [
                HomePage(),          // tab 0
                const AccountPage(), // tab 1
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              onTap: (i) =>
                  context.read<NavBloc>().add(ChangeTabEvent(i)),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Tài khoản',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
