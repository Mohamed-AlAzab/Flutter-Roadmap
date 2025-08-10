import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/constant/string.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_button.dart';
import 'package:flutter_roadmap/presentation/widget/coustom_text_field.dart';
import 'package:flutter_svg/svg.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

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
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  SizedBox(height: 48),
                  Text('Create your account', style: TextStyle(fontSize: 32)),
                  SizedBox(height: 24),
                  CoustomTextFormField(
                    controller: nameTextEditingController,
                    hintColor: Theme.of(context).colorScheme.primary,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    text: 'Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  CoustomTextFormField(
                    controller: emailTextEditingController,
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
                    controller: passwordTextEditingController,
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
                  SizedBox(height: 24),
                  CoustomTextFormField(
                    controller: confirmPasswordTextEditingController,
                    hintColor: Theme.of(context).colorScheme.primary,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    text: 'Confirm Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the confirm password';
                      }
                      // if(value.lenght < 8){
                      //   return 'Password should be more than 8';
                      // }
                      if (value != confirmPasswordTextEditingController.text) {
                        return 'Password don\'t match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  CoustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        print('True');
                      }
                    },
                    text: 'Sign Up',
                    color: Theme.of(context).colorScheme.onSurface,
                    textColor: Theme.of(context).colorScheme.surface,
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
