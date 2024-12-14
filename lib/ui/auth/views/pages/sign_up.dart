import 'package:atw_task/ui/auth/view_models/auth_cubit.dart';
import 'package:atw_task/ui/auth/views/pages/sign_in.dart';
import 'package:atw_task/ui/auth/views/widgets/back_button.dart';
import 'package:atw_task/ui/auth/views/widgets/button.dart';
import 'package:atw_task/ui/auth/views/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildBackButton(context),
            const SizedBox(height: 20),
            _buildHeaderText(),
            const SizedBox(height: 40),
            _buildForm(),
            const Expanded(child: SizedBox(height: double.infinity)),
            _buildSignUpButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's sign you up.",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        Text(
          'Hello.',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        Text(
          "Welcome",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

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
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Signup Successful"),
                backgroundColor: Colors.green),
          );
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

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        customButton(
          text: 'Sign up',
          onPressed: () {
            context.read<AuthCubit>().signUp(
                  emailController.text.trim(),
                  passwordController.text,
                );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? "),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              child: const Text(
                'Sign in',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
