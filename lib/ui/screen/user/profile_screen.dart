import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/auth/login_screen.dart';
import 'package:movie/ui/screen/user/cubit/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        title: Text("My Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: ColorPallete.colorPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              if (state is UserLoaded) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(state.data.image!),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${state.data.firstName} ${state.data.lastName}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "${state.data.email}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                );
              } else if (state is UserFailed) {
                return Text(
                  state.message,
                  style: TextStyle(color: Colors.white),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
            SizedBox(height: 20),
            _buildMenuItem(
                icon: Icons.favorite_border, title: "Favourites", onTap: () {}),
            _buildMenuItem(
                icon: Icons.download, title: "Downloads", onTap: () {}),
            Divider(),
            _buildMenuItem(
                icon: Icons.language, title: "Languages", onTap: () {}),
            _buildMenuItem(
                icon: Icons.location_on, title: "Location", onTap: () {}),
            _buildMenuItem(
                icon: Icons.subscriptions, title: "Subscription", onTap: () {}),
            _buildMenuItem(
                icon: Icons.display_settings, title: "Display", onTap: () {}),
            Divider(),
            _buildMenuItem(
                icon: Icons.delete_outline, title: "Clear Cache", onTap: () {}),
            _buildMenuItem(
                icon: Icons.history, title: "Clear History", onTap: () {}),
            _buildMenuItem(
                icon: Icons.logout,
                title: "Log Out",
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      {required IconData icon,
      required String title,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
      onTap: onTap,
    );
  }
}
