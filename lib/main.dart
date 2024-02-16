import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_flutter_case/utilities/locator.dart';
import 'package:reqres_flutter_case/utilities/shared_pref_helper.dart';
import 'package:reqres_flutter_case/views/home_view.dart';
import 'package:reqres_flutter_case/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  await locator.getAsync<SharedPrefHelper>();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: child,
      ),
      home: const _InitView(),
    );
  }
}

class _InitView extends StatelessWidget {
  const _InitView();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(locator<SharedPrefHelper>().readToken()),
      builder: (context, snapshot) {
        if (snapshot.data == null) return const LoginView();

        return const HomeView();
      },
    );
  }
}
