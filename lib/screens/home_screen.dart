import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../api/models/user.dart';
import 'user_detail_screen.dart' as detail; // Gunakan 'as' prefix untuk menghindari ambiguitas
import 'user_form_screen.dart' as form; // Gunakan 'as' prefix untuk menghindari ambiguitas

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> _usersFuture;
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _usersFuture = _apiService.getUsers();
  }

  void _navigateToAddUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const form.UserFormScreen()),
    ).then((value) {
      // Refresh state when returning from UserFormScreen
      if (value != null && value) {
        setState(() {
          _usersFuture = _apiService.getUsers();
        });
      }
    });
  }

  void _navigateToUserDetail(int userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => detail.UserDetailScreen(userId: userId)),
    ).then((value) {
      // Refresh state when returning from UserDetailScreen
      if (value != null && value) {
        setState(() {
          _usersFuture = _apiService.getUsers();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Pengguna'),
        backgroundColor: Colors.deepPurpleAccent, // Ganti warna latar belakang AppBar
      ),
      body: FutureBuilder(
        future: _usersFuture,
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          List<User> users = snapshot.data ?? [];
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              User user = users[index];
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(user.email),
                    onTap: () => _navigateToUserDetail(user.id),
                  ),
                  Divider(), // Tambahkan pembatas di antara item
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddUser,
        tooltip: 'Tambah Pengguna Baru',
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple, // Ganti warna latar belakang FAB
      ),
    );
  }
}