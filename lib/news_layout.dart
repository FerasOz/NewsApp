import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/cubit/cubit/news_cubit.dart';
import 'package:news_app/screens/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: const Icon(Icons.search_rounded)),
              IconButton(
                  onPressed: () {
                    NewsCubit.get(context).changeTheme();

                  }, icon: const Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItem,
            onTap: (index) {
              cubit.changeBottom(index);
            },
          ),
        );
      },
    );
  }
}