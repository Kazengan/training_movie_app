import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/screen/success/success_screen.dart';
import 'package:movie/ui/screen/ticket/cubit/ticket_cubit.dart';
import 'package:movie/ui/screen/ticket/ticket_screen.dart';

class SuccessPage extends StatelessWidget {
  final String id;
  const SuccessPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TicketCubit()..loadTickets(),
        ),
      ],
      child: SuccessScreen(id: id),
    );
  }
}
