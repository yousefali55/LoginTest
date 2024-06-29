import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintest/mutual_widgets/custom_snack_bar.dart';
import 'package:logintest/theming/colors_manager.dart';
import 'package:logintest/views/home/home_screen.dart';
import 'package:logintest/views/login/data/cubit/login_cubit.dart';
import 'package:logintest/views/login/widgets/dont_have_account.dart';
import 'package:logintest/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:logintest/mutual_widgets/repeated_text_field.dart';
import 'package:logintest/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:logintest/views/register/data/cubit/register_cubit.dart';
import 'package:logintest/views/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.green,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
              );
            } else if (state is LoginFailure) {
              showCustomSnackbar(
                  context, 'Failed, ${state.errorMessage}', ColorsManager.red);
            }
          },
          builder: (context, state) {
            final loginCubit = context.read<LoginCubit>();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.35),
                  Container(
                    height: height - 220,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextInSignInUp(
                          textWelcomeOrGetStarted: 'Welcome back!',
                        ),
                        RepeatedTextFormField(
                            icon: const Icon(Icons.person),
                            hide: false,
                            hintText: 'Enter email',
                            controller: loginCubit.emailController),
                        const SizedBox(
                          height: 25,
                        ),
                        RepeatedTextFormField(
                            icon: const Icon(Icons.key),
                            hide: true,
                            hintText: 'Enter password',
                            controller: loginCubit.passwordController),
                        const SizedBox(
                          height: 8,
                        ),
                        state is LoginLoading
                            ? const Center(
                              child: CircularProgressIndicator(
                                  color: ColorsManager.mainGreen,
                                ),
                            )
                            :  ElevatedButtonForSignInUp(
                                  signInOrUp: 'Sign In',
                                  onPressed: () {
                                    loginCubit.Login();
                                  },
                                ),
                        const SizedBox(
                          height: 30,
                        ),
                        DontHaveAccount(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => RegisterCubit(),
                                  child: const RegisterScreen(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
