import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_flutter_case/providers/login_provider.dart';
import 'package:reqres_flutter_case/utilities/assets_constant.dart';
import 'package:reqres_flutter_case/utilities/form_validators.dart';
import 'package:reqres_flutter_case/utilities/string_constant.dart';
import 'package:reqres_flutter_case/views/home_view.dart';
import 'package:reqres_flutter_case/views/register_view.dart';
import 'package:reqres_flutter_case/widgets/app_elevated_button.dart';
import 'package:reqres_flutter_case/widgets/app_form_field.dart';

final loginEmailProvider = StateProvider<String>((ref) => '');
final loginPasswordProvider = StateProvider<String>((ref) => '');

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView> {
  final formKey = GlobalKey<FormState>();

  void updateEmail(String v) {
    ref.read(loginEmailProvider.notifier).state = v;
  }

  void updatePassword(String v) {
    ref.read(loginPasswordProvider.notifier).state = v;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          AssetConstant.authBackground,
                        ),
                      ),
                      Flexible(
                        child: AppFormField(
                          hintText: StringConstant.emailHint,
                          onChanged: updateEmail,
                          validator: emailFormValidator,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: AppFormField(
                          hintText: StringConstant.passwordHint,
                          onChanged: updatePassword,
                          validator: passwordFormValidator,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                loginConsumer(),
                signUpButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Consumer loginConsumer() {
    return Consumer(
      builder: (context, ref, __) {
        final loginState = ref.watch(loginProvider);
        if (loginState?.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        loginState?.whenData((data) {
          if (data.error != null || loginState.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data.error!)));
            return;
          }
        });

        return AppElevatedButton(
          text: StringConstant.loginText,
          onPressed: () async {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
                (route) => false);
            //! BAD RESPONSE 400
            /*
                       if (formKey.currentState!.validate()) {
                        await ref.read(loginProvider.notifier).login(ref);

                        if (loginState?.value != null && loginState?.error == null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeView(),
                              ),
                              (route) => false);
                        }
                      }
                     */
          },
        );
      },
    );
  }

  TextButton signUpButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const RegisterView(),
      )),
      child: const Text('${StringConstant.registerText}?'),
    );
  }
}
