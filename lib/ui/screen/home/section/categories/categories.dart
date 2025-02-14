import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/home/section/categories/cubit/categories_cubit.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Categories',
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
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoaded) {
              return SizedBox(
                height: 40,
                child: ListView.separated(
                  itemCount: state.data.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (context, index) {
                    var category = state.data[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorPallete.colorSecondary),
                      child: Center(
                        child: Text(
                          category.name,
                          style: TextStyle(color: ColorPallete.colorWhite),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is CategoriesFailed) {
              return Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}
