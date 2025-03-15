import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/cubit/cubit/news_cubit.dart';
    
class ScienceScreen extends StatelessWidget {

  const ScienceScreen({ super.key });
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {

        var list = NewsCubit.get(context).science;

        return articleBuilder(list, context);
      },
    );
  }
}