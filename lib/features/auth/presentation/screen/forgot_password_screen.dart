import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/routs_string.dart';
import 'package:flutter_roadmap/core/constant/string.dart';
import 'package:flutter_roadmap/core/utils/helper.dart';
import 'package:flutter_roadmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/auth_button.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/coustom_text_field.dart';
import 'package:flutter_roadmap/features/auth/presentation/widget/custom_snack_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
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
                  Text('Reset Password', style: TextStyle(fontSize: 32)),
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            loginScreen,
                            (context) => false,
                          );
                        },
                        child: Text(
                          'Back to login Page',
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
                      if (state is ResetPasswordState) {
                        if (state.message == resetPasswordByEmailString) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            loginScreen,
                            (context) => false,
                          );
                        }
                        Message(
                          context: context,
                          message: '${state.message} (Check spam)',
                          color: state.message == resetPasswordByEmailString
                              ? Colors.green
                              : Colors.red,
                        );
                      } else if (state is AuthError) {
                        Message(
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
                              ResetPasswordEvent(emailController.text),
                            );
                          }
                        },
                        isLoading: state is AuthLoading,
                        text: 'Send Email',
                      );
                    },
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
