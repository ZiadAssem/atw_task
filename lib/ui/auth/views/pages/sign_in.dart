import 'package:atw_task/ui/auth/view_models/auth_cubit.dart';
import 'package:atw_task/ui/auth/views/pages/sign_up.dart';
import 'package:atw_task/ui/auth/views/widgets/back_button.dart';
import 'package:atw_task/ui/auth/views/widgets/button.dart';
import 'package:atw_task/ui/auth/views/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: buildBackButton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText(),
            const SizedBox(height: 40),
            _buildForm(),
            const Expanded(child: SizedBox(height: double.infinity)),
            _buildAuthSignInButton(),
          ],
        ),
      ),
    );
  }

  /// Header Texts Widget
  Widget _buildHeaderText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's sign you in.",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Welcome back.',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
        ),
        Text(
          "You've been missed",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  /// Form Widget with Input Fields
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            label: 'Email',
            controller: emailController,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomInputField(
            label: 'Password',
            controller: passwordController,
            hintText: 'Password',
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// BlocConsumer for Authentication Logic
  Widget _buildAuthSignInButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          _showSnackBar(context, state.error, Colors.red);
        } else if (state is AuthSuccess) {
          _showSnackBar(context, "Login Successful", Colors.green);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildActionButtons(context);
      },
    );
  }

  /// Action Buttons for Sign In and Register
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        customButton(
          text: 'Sign in',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().signIn(
                    emailController.text.trim(),
                    passwordController.text,
                  );
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account? "),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: const Text(
                'Register',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Helper function to show SnackBars
  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}
