import 'package:clean_flutter_poc/modules/auth/login/presenters/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: userNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(OnLoginEvent(
                    userNameController.text, passwordController.text));
              },
              child: Text("Login"),
            ),
            SizedBox(height: 32.0),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoginHasData) {
                  return Center(
                    child: Column(
                      key: Key('login_data'),
                      children: [Text('Login Success')],
                    ),
                  );
                } else if (state is AuthError) {
                  return Center(
                    child: Text('Something went wrong!'),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
