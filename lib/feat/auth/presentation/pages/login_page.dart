import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sccc_v3/feat/auth/data/model/request/login_req.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_button_cubit.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_button_states.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_cubit.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_states.dart';
import 'package:sccc_v3/feat/auth/presentation/widgets/auth_button.dart';
import 'package:sccc_v3/feat/auth/presentation/widgets/auth_page_info_text.dart';
import 'package:sccc_v3/feat/auth/presentation/widgets/auth_prompt_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _passwordVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _passwordVisible.value = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthButtonCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthButtonCubit, AuthButtonStates>(
            listener: (context, state) {
              if (state is ButtonSuccess) {
                context.replace('/');
              } else if (state is ButtonFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          BlocListener<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is Authenticated) {
                context.replace('/');
              } else if (state is UnAuthenticated) {
                if (state.message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message ?? 'Login failed. Please try  later.'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AuthPageInfoText(
                      pageTitle: 'Login',
                      infoTextSub: 'Welcome back! Please enter your credentials to continue.',
                    ),
                    SizedBox(height: 40),
                    LoginForm(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordVisible: _passwordVisible,
                      passwordController: _passwordController,
                    ),
                    SizedBox(height: 24),
                    AuthPromptText(
                      promptText: 'Don\'t have an account?',
                      actionText: 'Register here.',
                      route: '/register',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required ValueNotifier<bool> passwordVisible,
    required TextEditingController passwordController,
  }) : _formKey = formKey,
       _emailController = emailController,
       _passwordVisible = passwordVisible,
       _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final ValueNotifier<bool> _passwordVisible;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email', hintText: 'example@email.com'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (EmailValidator.validate(value) == false) {
                return 'Invalid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 30),
          ValueListenableBuilder<bool>(
            valueListenable: _passwordVisible,
            builder: (context, isVisible, child) {
              return TextFormField(
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
                obscureText: !isVisible, // Fix visibility logic
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              );
            },
          ),
          SizedBox(height: 20),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     alignment: Alignment.centerRight,
          //     child: Text(
          //       "Forgot password?",
          //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //         color: Theme.of(context).colorScheme.primary,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 30),
          AuthButton(
            title: "Login",
            height: 56,
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // ✅ Proceed with form submission
                context.read<AuthCubit>().signInWithEmailAndPassword(
                  LoginReqParams(email: _emailController.text.trim(), password: _passwordController.text.trim()),
                );
              } else {
                // ❌ Show error message
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Please fill in all fields correctly')));
              }
            },
          ),
        ],
      ),
    );
  }
}
