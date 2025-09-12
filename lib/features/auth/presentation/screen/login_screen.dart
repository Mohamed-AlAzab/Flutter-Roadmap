import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/auth_button.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/coustom_text_field.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/signin_with_github_button.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/signin_with_google_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    text: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6),
                  CoustomTextFormField(
                    controller: passwordController,
                    text: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6),
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
                        CustomSnackBar(
                          context: context,
                          message: 'Login Successfully',
                          color: Colors.green,
                        );
                      }
                      if (state is Unauthenticated) {
                        if (state.unauthenticatedMessage != null) {
                          CustomSnackBar(
                            context: context,
                            message: state.unauthenticatedMessage!,
                            color: Colors.red,
                          );
                        }
                      }
                      if (state is AuthError) {
                        CustomSnackBar(
                          context: context,
                          message: state.message,
                          color: Colors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      return AuthButton(
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
                        isLoading: state is AuthLoading,
                        text: 'Login',
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
                            signupScreen,
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
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text('  Or  ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return SigninWithGoogleButton(
                            onTap: () async {
                              context.read<AuthBloc>().add(
                                SignInWithGoogleEvent(),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return SigninWithGithubButton(
                            onTap: () async {
                              context.read<AuthBloc>().add(
                                SignInWithGithubEvent(),
                              );
                            },
                          );
                        },
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
