import 'package:bloc_nearly_complete/features/auth/presentation/bloc/login_bloc.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/login_event.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/login_state.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _tax = TextEditingController();
  final _user = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (ctx, state) {
          if (state is LoginSuccess) {
            Navigator.of(ctx).pushReplacement(
              MaterialPageRoute(builder: (_) => const MainPage()),
            );
          }
        },
        builder: (ctx, state) {
          final err = state is LoginFailure ? state : null;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Tax field ──
                TextFormField(
                  controller: _tax,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('Mã số thuế')),
                ),
                if (err?.taxError != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      err!.taxError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 12),

                // ── Username field ──
                TextFormField(
                  controller: _user,
                  decoration:
                      const InputDecoration(label: Text('Tên đăng nhập')),
                ),
                if (err?.usernameError != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      err!.usernameError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 12),

                // ── Password field ──
                TextFormField(
                  controller: _pass,
                  obscureText: true,
                  decoration: const InputDecoration(label: Text('Mật khẩu')),
                ),
                if (err?.passwordError != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      err!.passwordError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 24),

                // ── Submit ──
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ctx.read<LoginBloc>().add(
                            LoginSubmitEvent(
                              tax: _tax.text,
                              username: _user.text,
                              password: _pass.text,
                            ),
                          );
                    },
                    child: const Text('Đăng nhập'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
