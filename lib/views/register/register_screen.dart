import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintest/views/login/login_screen.dart';
import 'package:logintest/mutual_widgets/custom_snack_bar.dart';
import 'package:logintest/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:logintest/mutual_widgets/repeated_text_field.dart';
import 'package:logintest/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:logintest/views/register/data/cubit/register_cubit.dart';
import 'package:logintest/theming/colors_manager.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: height *.4,
                ),
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registration Done!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    } else if (state is RegisterFailure) {
                      showCustomSnackbar(
                        context,
                        'Failed, ${state.errorMessage}',
                        ColorsManager.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Form(
                          onChanged: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const TextInSignInUp(
                                  textWelcomeOrGetStarted: 'Create account'),
                              RepeatedTextFormField(
                                hide: false,
                                hintText: 'Enter email',
                                controller: context
                                    .read<RegisterCubit>()
                                    .emailController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              RepeatedTextFormField(
                                hide: true,
                                hintText: 'Password',
                                controller: context
                                    .read<RegisterCubit>()
                                    .passwordController,
                              ),
                               const SizedBox(
                                height: 20,
                              ),
                              state is RegisterLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorsManager.mainGreen,
                                      ),
                                    )
                                  : ElevatedButtonForSignInUp(
                                      signInOrUp: 'Sign Up',
                                      onPressed: () {
                                        context
                                            .read<RegisterCubit>()
                                            .register();
                                      }),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
