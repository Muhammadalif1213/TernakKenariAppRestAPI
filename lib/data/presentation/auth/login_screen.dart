import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/core/components/buttons.dart';
import 'package:rest_api/core/components/custom_text_field.dart';
import 'package:rest_api/core/components/spaces.dart';
import 'package:rest_api/core/core.dart';
import 'package:rest_api/data/models/request/auth/login_request_model.dart';
import 'package:rest_api/data/presentation/auth/login/login_bloc.dart';
import 'package:rest_api/screens/admin_confirm_screen.dart';
import 'package:rest_api/data/presentation/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _key.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(170),
                Text(
                  'Selamat datang kembali',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SpaceHeight(30),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  validator: 'Email tidak boleh kosong',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.email),
                  ),
                ),
                const SpaceHeight(25),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: !isShowPassword,
                  validator: 'Password tidak boleh kosong',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                  ),
                ),
                const SpaceHeight(30),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    } else if (state is LoginSuccess) {
                      final role =
                          state.responseModel.user?.role?.toLowerCase();
                      if (role == 'admin') {
                        context.pushAndRemoveUntil(
                          const AdminConfirmScreen(),
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Role tidak dikenali')),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    return Button.filled(
                      onPressed:
                          state is LoginLoading
                              ? null
                              : () {
                                if (_key.currentState!.validate()) {
                                  final request = LoginRequestModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  context.read<LoginBloc>().add(
                                    LoginRequested(requestModel: request),
                                  );
                                }
                              },
                      label: state is LoginLoading ? 'memuat...' : 'Masuk',
                    );
                  },
                ),

                const SpaceHeight(20),
                Text.rich(
                  TextSpan(
                    text: 'Belum punya akun?',
                    children: [
                      TextSpan(
                        text: ' Daftar disini',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                context.push(const RegisterScreen());
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
