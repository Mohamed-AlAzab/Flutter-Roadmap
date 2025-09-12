import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/auth_button.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/coustom_text_field.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:flutter_svg/svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/signin.svg',
                    width: context.width * 0.5,
                  ),
                  SizedBox(height: 48),
                  Text('Create your account', style: TextStyle(fontSize: 32)),
                  SizedBox(height: 24),
                  CoustomTextFormField(
                    controller: nameController,
                    text: 'Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6),
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
                      if (value.length < 6) {
                        return 'Password should be more than 6';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6),
                  CoustomTextFormField(
                    controller: confirmPasswordController,
                    text: 'Confirm Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the confirm password';
                      }
                      if (value.length < 6) {
                        return 'Password should be more than 6';
                      }
                      if (value != passwordController.text) {
                        return 'Password don\'t match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6),
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
                              RegisterEvent(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                          }
                        },
                        isLoading: state is AuthLoading,
                        text: 'Sign Up',
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff59738C),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            loginScreen,
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff0D78F2),
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
