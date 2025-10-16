import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:shophomework/screens/customclipper.dart';
import 'package:shophomework/viewmodel/login_bloc/login_bloc.dart';
import 'package:shophomework/viewmodel/login_bloc/login_event.dart';
import 'package:shophomework/viewmodel/login_bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObsercure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          final username = emailController.text.trim();
          context.go('/home?username=$username');
        } else if (state is LoginFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInitial) {
            return _buildLoginUI(context, false);
          } else if (state is LoginLoading) {
            return _buildLoginUI(context, true);
          } else if (state is LoginSuccess) {
            return _buildLoginUI(context, false);
          } else if (state is LoginFailure) {
            return _buildLoginUI(context, false);
          }
          return _buildLoginUI(context, false);
        },
      ),
    );
  }

  Widget _buildLoginUI(BuildContext context, bool isLoading) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: MyCustomClipper(),
              child: Container(height: 200, color: Colors.pink),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'login',
                      style: TextStyle(fontSize: 30, color: Colors.pink),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "yourmail@gmail.com",
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: isObsercure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open_outlined),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObsercure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isObsercure = !isObsercure;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    final username = emailController.text
                                        .trim();
                                    final password = passwordController.text
                                        .trim();

                                    context.read<LoginBloc>().add(
                                      LoginButtonPressed(username, password),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Login'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Column(
                        children: [
                          const Text("Join with"),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              _SocialIcon(icon: FontAwesomeIcons.google),
                              SizedBox(width: 10),
                              _SocialIcon(icon: FontAwesomeIcons.twitter),
                              SizedBox(width: 10),
                              _SocialIcon(icon: FontAwesomeIcons.linkedinIn),
                              SizedBox(width: 10),
                              _SocialIcon(icon: FontAwesomeIcons.facebook),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: Colors.pink,
      child: FaIcon(icon, color: Colors.white, size: 15),
    );
  }
}
