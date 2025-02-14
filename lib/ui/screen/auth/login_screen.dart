import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/repositories/auth_repository.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/auth/cubit/auth_cubit.dart';
import 'package:movie/ui/screen/main_page.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    final username = usernameController.text;
    final password = passwordController.text;
    context.read<AuthCubit>().login(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        backgroundColor: ColorPallete.colorPrimary,
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(AuthRepository()),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Welcome, ${state.user.firstName}!')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
              );
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.movie_outlined,
                    size: 100,
                  ),
                  Text(
                    'Toyota\nMovie App',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                    ),
                    onSubmitted: (_) {
                      // Focus ke password field saat enter ditekan di username field
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next, // Menampilkan tombol "Next" di keyboard
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      // Ambil state password visibility dari cubit
                      final isObscure =
                          context.watch<AuthCubit>().isPasswordVisible;

                      return TextField(
                        controller: passwordController,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<AuthCubit>()
                                  .togglePasswordVisibility();
                            },
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) {
                          // Jalankan fungsi login saat enter ditekan di password field
                          _login(context);
                        },
                        textInputAction: TextInputAction.done, // Menampilkan tombol "Done" atau "Go" di keyboard
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return CircularProgressIndicator();
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ColorPallete.colorPrimary),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(16)),
                          ),
                          onPressed: () {
                            _login(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}