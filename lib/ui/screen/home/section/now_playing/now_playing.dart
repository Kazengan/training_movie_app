import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/constant/constants.dart';
import 'package:movie/ui/screen/detail/detail_page.dart';
import 'package:movie/ui/screen/home/section/now_playing/cubit/now_playing_cubit.dart';

class NowPlayingSection extends StatelessWidget {
  const NowPlayingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Now Playing',
                style: TextStyle(
                    color: ColorPallete.colorWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              'View All',
              style: TextStyle(
                color: ColorPallete.colorOrange,
                fontSize: 12,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<NowPlayingCubit, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingLoaded) {
              return CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 280,
                  disableCenter: true,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.6,
                ),
                items: state.data.map((i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(  // Changed pushReplacement to push
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMoviePage(
                            id: i.id!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          margin: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${Constants.imageBaseUrl}${'/original'}${i.posterPath}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          i.title ?? '-',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            } else if (state is NowPlayingFailed) {
              return Text(
                state.message,
                style: TextStyle(color: Colors.white),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}