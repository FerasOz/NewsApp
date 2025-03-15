import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/cubit/cubit/news_cubit.dart';
import 'package:responsive_builder/responsive_builder.dart';
    
class BusinessScreen extends StatelessWidget {

  const BusinessScreen({ super.key });
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;

        return ScreenTypeLayout(
          mobile: Builder(
              builder: (context){
            NewsCubit.get(context).setDesktop(false);
            return articleBuilder(list, context);
          }),
          desktop: Builder(builder: (context){
            NewsCubit.get(context).setDesktop(true);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: articleBuilder(list, context)),
                if(list.isNotEmpty)
                  Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            '${list[NewsCubit.get(context).currentIndexBusiness]['description']}',
                            style: const TextStyle(
                              fontSize: 25.0,
                            ),

                          ),
                        ),
                      ))
              ],
            );
          }),
          breakpoints: const ScreenBreakpoints(
              desktop: 850.0, tablet: 500.0, watch: 300.0),
        );
      },
    );
  }
}