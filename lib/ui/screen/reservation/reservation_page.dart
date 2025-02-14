import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/screen/reservation/cubit/reservation_cubit.dart';
import 'package:movie/ui/screen/reservation/reservation_screen.dart';

class ReservationPage extends StatelessWidget {
  final int idMovie;
  final String title;
  final String imagePath;

  const ReservationPage({super.key, required this.idMovie, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ReservationCubit()..generateRandomBookedSeats(),
        ),
      ],
      child: ReservationScreen(idMovie: idMovie, title: title, imagePath: imagePath,),
    );
  }
}
