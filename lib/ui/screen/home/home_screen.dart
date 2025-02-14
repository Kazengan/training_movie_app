import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/home/section/categories/categories.dart';
import 'package:movie/ui/screen/home/section/now_playing/now_playing.dart';
import 'package:movie/ui/screen/home/section/upcoming/upcoming.dart';
import 'package:movie/ui/screen/search/search_page.dart';
import 'package:movie/ui/screen/user/cubit/user_cubit.dart';

class HomeScreen extends StatefulWidget {
  final Function(int index) onChangePage;
  const HomeScreen({super.key, required this.onChangePage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> category = ['Action', 'Comedy', 'Horor', 'Romantic'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<UserCubit, UserState>(builder: (context, state) {
                  if (state is UserLoaded) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome ${state.data.firstName} 👋',
                                style: TextStyle(
                                    color: ColorPallete.colorGrey,
                                    fontSize: 14),
                              ),
                              Text(
                                "Let's Relax and watch a movie !",
                                style: TextStyle(
                                    color: ColorPallete.colorWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            widget.onChangePage(3);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              state.data.image!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
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
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: ColorPallete.colorWhite),
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                          query: value,
                        ),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                      hintText: 'Search movie...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            BorderSide(width: 1, color: ColorPallete.colorGrey),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: ColorPallete.colorSecondary,
                      prefixIconColor: ColorPallete.colorGrey,
                      hintStyle: TextStyle(color: ColorPallete.colorGrey)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CategoriesSection(),
                const SizedBox(
                  height: 20,
                ),
                const NowPlayingSection(),
                const UpcomingSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
