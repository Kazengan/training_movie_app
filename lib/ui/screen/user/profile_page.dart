import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/screen/user/cubit/user_cubit.dart';
import 'package:movie/ui/screen/user/profile_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit()..gerUser(),
        ),
      ],
      child: ProfileScreen(),
    );
  }
}
