import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  Widget buildCategoryBox(
      String title, String imagePath, BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(CategoryDetailRoute(title: title));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.transparent,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kategoriler',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 2,
              children: [
                buildCategoryBox(
                    'Erkek', 'assets/images/erkek-giyim.webp', context),
                buildCategoryBox(
                    'Kadın', 'assets/images/kadin-giyim.jpg', context),
                buildCategoryBox(
                    'Çocuk', 'assets/images/cocuk-giyim.webp', context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
