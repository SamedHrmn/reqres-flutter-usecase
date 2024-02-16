import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_flutter_case/providers/users_provider.dart';
import 'package:reqres_flutter_case/widgets/user_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).getAllUsers(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final usersState = ref.watch(usersProvider);

            if (usersState?.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            final userList = usersState?.value?.data ?? [];

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemBuilder: (context, index) => UserCard(user: userList[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: userList.length,
            );
          },
        ),
      ),
    );
  }
}
