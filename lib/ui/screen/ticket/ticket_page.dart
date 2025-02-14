import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/screen/ticket/cubit/ticket_cubit.dart';
import 'package:movie/ui/screen/ticket/ticket_screen.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TicketCubit()..loadTickets(),
        ),
      ],
      child: TicketScreen(),
    );
  }
}