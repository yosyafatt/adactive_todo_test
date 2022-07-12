import 'package:flutter/material.dart';

import 'core/dependency_manager.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login with Google",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                getIt<AuthBloc>().add(AuthLogin());
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
