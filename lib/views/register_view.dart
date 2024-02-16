import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_flutter_case/providers/register_provider.dart';
import 'package:reqres_flutter_case/utilities/assets_constant.dart';
import 'package:reqres_flutter_case/utilities/form_validators.dart';
import 'package:reqres_flutter_case/utilities/string_constant.dart';
import 'package:reqres_flutter_case/views/login_view.dart';
import 'package:reqres_flutter_case/widgets/app_elevated_button.dart';
import 'package:reqres_flutter_case/widgets/app_form_field.dart';

final registerEmailProvider = StateProvider<String>((ref) => '');
final registerPasswordProvider = StateProvider<String>((ref) => '');
final registerUsernameProvider = StateProvider<String>((ref) => '');

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends ConsumerState<RegisterView> {
  final formKey = GlobalKey<FormState>();

  void updateEmail(String v) {
    ref.read(registerEmailProvider.notifier).state = v;
  }

  void updatePassword(String v) {
    ref.read(registerPasswordProvider.notifier).state = v;
  }

  void updateUsername(String v) {
    ref.read(registerUsernameProvider.notifier).state = v;
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
                          hintText: StringConstant.usernameHint,
                          onChanged: updateUsername,
                          validator: usernameFormValidator,
                        ),
                      ),
                      const SizedBox(height: 24),
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
                registerConsumer(),
                loginButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Consumer registerConsumer() {
    return Consumer(
      builder: (context, ref, __) {
        final registerState = ref.watch(registerProvider);

        if (registerState?.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        registerState?.whenData((data) {
          if (data.error != null || registerState.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data.error!)));
            return;
          }
        });

        return AppElevatedButton(
          text: StringConstant.registerText,
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              //! BAD RESPONSE 400
              /*await ref.read(registerProvider.notifier).register(ref);

              if (registerState?.value != null && registerState?.error == null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                    (route) => false);
                   
              }
              */
            }
          },
        );
      },
    );
  }

  TextButton loginButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginView(),
      )),
      child: const Text('${StringConstant.loginText}?'),
    );
  }
}
