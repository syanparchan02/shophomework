import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shophomework/model/user.dart';
import 'package:shophomework/screens/customclipper.dart';

import 'package:shophomework/viewmodel/user_bloc/user_bloc.dart';
import 'package:shophomework/viewmodel/user_bloc/user_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

@override
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isObsercure = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitialState) {
          return const Center(child: Text('Welcome to User Screen'));
        } else if (state is UserLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoadedState) {
          List<UserModel> ulist = state.userlist;
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
                          Text(
                            'login',
                            style: TextStyle(fontSize: 30, color: Colors.pink),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: "yourmail@gamil.com",
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }

                              return null;
                            },
                            controller: passwordController,
                            obscureText: isObsercure,

                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_open_outlined),
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
                          SizedBox(height: 5),
                          Text(
                            "forgot password?",
                            style: TextStyle(color: Colors.pink),
                          ),
                          SizedBox(height: 50),
                          Center(
                            child: SizedBox(
                              width: 250,

                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    UserModel? matchedUser;
                                    for (var user in ulist) {
                                      if (user.email == emailController.text &&
                                          user.password ==
                                              passwordController.text) {
                                        matchedUser = user;
                                        break;
                                      }
                                    }

                                    if (matchedUser != null) {
                                      context.go(
                                        '/home?username=${matchedUser.username}',
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Invalid email or password',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },

                                child: Text('Login'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          Center(
                            child: Column(
                              children: [
                                Text("Join with"),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.pink,
                                      child: FaIcon(
                                        FontAwesomeIcons.google,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.pink,
                                      child: FaIcon(
                                        FontAwesomeIcons.twitter,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.pink,
                                      child: FaIcon(
                                        FontAwesomeIcons.linkedinIn,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.pink,
                                      child: FaIcon(
                                        FontAwesomeIcons.facebook,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
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
        } else if (state is UserErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
