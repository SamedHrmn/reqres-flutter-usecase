import 'package:flutter/material.dart';
import 'package:reqres_flutter_case/models/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 10,
        ),
      ]),
      height: 100,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              user.avatar ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Placeholder(),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${user.firstName ?? ''} ${user.lastName ?? ''}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
