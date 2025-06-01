import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sccc_v3/feat/auth/data/model/request/register_req.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_cubit.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_states.dart';
import 'package:sccc_v3/feat/auth/presentation/widgets/auth_page_info_text.dart';
import 'package:sccc_v3/feat/auth/presentation/widgets/auth_prompt_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordVisible = ValueNotifier<bool>(false);
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible.value = false;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is Authenticated) {
          return;
        } else if (state is UnAuthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  AuthPageInfoText(
                    pageTitle: 'Register',
                    infoTextSub: 'Please fill in the details to create an account.',
                  ),
                  SizedBox(height: 32),
                  RegisterForm(
                    formKey: _formKey,
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    emailController: _emailController,
                    passwordVisible: _passwordVisible,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  SizedBox(height: 24),
                  AuthPromptText(promptText: "Already have an account?", actionText: "Login here.", route: "/login"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController emailController,
    required ValueNotifier<bool> passwordVisible,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) : _formKey = formKey,
       _firstNameController = firstNameController,
       _lastNameController = lastNameController,
       _emailController = emailController,
       _passwordVisible = passwordVisible,
       _passwordController = passwordController,
       _confirmPasswordController = confirmPasswordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final TextEditingController _emailController;
  final ValueNotifier<bool> _passwordVisible;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email', hintText: 'example@email.com'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (EmailValidator.validate(value) == false) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ValueListenableBuilder<bool>(
            valueListenable: _passwordVisible,
            builder: (context, isVisible, child) {
              return Column(
                children: [
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          _passwordVisible.value = !isVisible;
                        },
                      ),
                    ),
                    obscureText: !isVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'Password must contain at least one lowercase letter';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: !isVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm password is required';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 32),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // ✅ Proceed with form submission
                context.read<AuthCubit>().signUpWithEmailAndPassword(
                  RegisterReqParams(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              } else {
                // ❌ Show error message
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Please fill in all fields correctly')));
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
