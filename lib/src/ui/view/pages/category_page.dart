import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  Widget buildCategoryBox(String title, String imagePath) {
    return InkWell(
      onTap: () {},
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
                buildCategoryBox('Erkek', 'assets/images/erkek-giyim.webp'),
                buildCategoryBox('Kadin', 'assets/images/kadin-giyim.jpg'),
                buildCategoryBox('Çocuk', 'assets/images/cocuk-giyim.webp'),
                buildCategoryBox('Aksesuar', 'assets/images/aksesuar.jpg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';

// @RoutePage()
// class CategoryPage extends StatelessWidget {
//   const CategoryPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Kategoriler',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 2,
//               children: [
//                 buildCategoryBox('Erkek', 'assets/images/erkek-giyim.webp'),
//                 buildCategoryBox('Kadin', 'assets/images/kadin-giyim.jpg'),
//                 buildCategoryBox('Çocuk', 'assets/images/cocuk-giyim.webp'),
//                 buildCategoryBox('Aksesuar', 'assets/images/aksesuar.jpg'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   //Kutucukların işlemleri için açıldı.(ad,arkaplan,renk)
//   Widget buildCategoryBox(String categoryName, String backgroundImage) {
//     return InkWell(
//       onTap: () {
//         // Yönlendirme işlemleri MERVE İÇİN EKLEDİM!!!!!!!
//       },
//       child: Container(
//         margin: const EdgeInsets.all(8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   backgroundImage,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(8),
//               color: Colors.transparent,
//               child: Text(
//                 categoryName,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
