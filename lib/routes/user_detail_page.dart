import 'package:flutter/material.dart';
import '../screens/user_detail_screen.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;

  const UserDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: UserDetailScreen(userId: userId),
    );
  }
}
