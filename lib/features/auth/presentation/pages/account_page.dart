import 'package:bloc_nearly_complete/features/auth/presentation/bloc/login_bloc.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/login_event.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Reset LoginBloc về trạng thái ban đầu
            context.read<LoginBloc>().add(LogoutEvent());
            // Xóa toàn bộ stack, đưa về LoginPage
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => LoginPage()),
              (route) => false,
            );
          },
          child: const Text('Đăng xuất'),
        ),
      ),
    );
  }
}
