import 'package:flutter/material.dart';
import '../api/models/user.dart';
import '../routes/user_detail_page.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserDetailPage(userId: user.id)),
        );
      },
      child: Card(
        child: ListTile(
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.email),
        ),
      ),
    );
  }
}
