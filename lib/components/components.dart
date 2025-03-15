import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/cubit/cubit/news_cubit.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (Route<dynamic> route) => false,
);

Widget divider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(width: double.infinity, height: 1.0, color: Colors.grey),
);

Widget buildArticleItem(article, context, index) => Container(
  color:
      NewsCubit.get(context).currentIndexBusiness == index &&
              NewsCubit.get(context).isDesktop
          ? Colors.grey[200]
          : null,
  child: InkWell(
    onTap: () {
      // navigateTo(context, WebViewScreen(article['url']));

      NewsCubit.get(context).selectedBusinessItem(index);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder:
      (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder:
            (context, index) => buildArticleItem(list[index], context, index),
        separatorBuilder: (context, index) => divider(),
        itemCount: list.length,
      ),
  fallback:
      (context) =>
          isSearch
              ? Container()
              : const Center(child: CircularProgressIndicator()),
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool? isClickable,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      enabled: isClickable,
      obscureText: isPassword,
      onFieldSubmitted: (value) {
        return onSubmit!(value);
      },
      onChanged: (value) {
        return onChange!(value);
      },
      validator: (value) {
        return validate!(value);
      },
      onTap: () {
        return onTap!();
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
    );


