import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_roadmap/core/widget/coustom_button.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/coustom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: context.height),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/login.svg',
                    width: context.width * 0.5,
                  ),
                  SizedBox(height: 48),
                  Text('Welcome back', style: TextStyle(fontSize: 32)),
                  SizedBox(height: 24),
                  CoustomTextFormField(
                    controller: emailController,
                    hintColor: Theme.of(context).colorScheme.primary,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    text: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  CoustomTextFormField(
                    controller: passwordController,
                    hintColor: Theme.of(context).colorScheme.primary,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    text: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the password';
                      }
                      // if(value.lenght < 8){
                      //   return 'Password should be more than 8';
                      // }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, forgotPasswordScreen);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is Authenticated) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          roadmapScreen,
                          (Route<dynamic> route) => false,
                        );
                      }
                      if (state is Unauthenticated) {}
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return CircularProgressIndicator();
                      }
                      return CoustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              LoginEvent(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                          }
                        },
                        text: 'Login',
                        color: Theme.of(context).colorScheme.onSurface,
                        textColor: Theme.of(context).colorScheme.surface,
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff59738C),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            signinScreen,
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
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
