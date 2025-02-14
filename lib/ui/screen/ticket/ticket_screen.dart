import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/ticket.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/detail/detail_page.dart';
import 'package:movie/ui/screen/search/widgets/movie_card.dart';
import 'package:movie/ui/screen/ticket/cubit/ticket_cubit.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        title: const Text(
          'Ticket',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorPallete.colorPrimary,
      ),
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          if (state is TicketLoaded) {
            if (state.tickets.isEmpty) {
              return Center(
                  child: Text(
                "Tiket belum ada",
                style: TextStyle(color: Colors.white),
              ));
            }
            return ListView.builder(
              itemCount: state.tickets.length,
              itemBuilder: (context, index) {
                final ticket = state.tickets[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMoviePage(
                          id: state.tickets[index].idMovie,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            '${state.tickets[index].urlImage}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.photo);
                            },
                            width: 100,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.tickets[index].id ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.tickets[index].title ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${state.tickets[index].date}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rp.${state.tickets[index].price}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
