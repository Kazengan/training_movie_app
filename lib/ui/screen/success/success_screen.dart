import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/domain/entities/ticket.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/detail/detail_page.dart';
import 'package:movie/ui/screen/search/widgets/movie_card.dart';
import 'package:movie/ui/screen/ticket/cubit/ticket_cubit.dart';
import 'package:movie/ui/screen/ticket/ticket_page.dart';

class SuccessScreen extends StatelessWidget {
  final String id;
  const SuccessScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          if (state is TicketLoaded) {
            var data = state.tickets.firstWhere((element) => element.id == id);
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/success.json', width: 200),
                  SizedBox(height: 16),
                  Text(
                    'Pembelian Tiket\nBerhasil',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'ID Pemesanan',
                        style: TextStyle(color: Colors.white),
                      )),
                      Expanded(
                          child: Text(
                        '${data.id}',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'Judul Film',
                        style: TextStyle(color: Colors.white),
                      )),
                      Expanded(
                          child: Text(
                        '${data.title}',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'Nomor Kursi',
                        style: TextStyle(color: Colors.white),
                      )),
                      Expanded(
                          child: Text(
                        '${data.seat}',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'Tanggal',
                        style: TextStyle(color: Colors.white),
                      )),
                      Expanded(
                          child: Text(
                        '${data.date}',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'Harga',
                        style: TextStyle(color: Colors.white),
                      )),
                      Expanded(
                          child: Text(
                        'Rp${data.price}',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPallete.colorOrange),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketPage(),
                          ));
                    },
                    child: Text("Lihat Tiket",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
