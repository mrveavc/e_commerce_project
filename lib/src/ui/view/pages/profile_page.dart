// import 'package:auto_route/auto_route.dart';
// import 'package:e_commerce_project/src/common/toast.dart';
// import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// @RoutePage()
// class ProfilPage extends StatefulWidget {
//   const ProfilPage({super.key});

//   @override
//   State<ProfilPage> createState() => _ProfilPageState();
// }

// class _ProfilPageState extends State<ProfilPage> {
//   // final authStore = getIt.get<AuthStore>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // final autoStore = getIt.get<AuthStore>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   leading: IconButton(
//         //       onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),
//         //   title: const Text('Profil'),
//         // ),
//         body: SingleChildScrollView(
//       child: Center(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             const SizedBox(
//               height: 200,
//               width: 200,
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/avatar.jpg'),
//                 radius: 50,
//               ),
//             ),
//             // const SizedBox(
//             //   height: 10,
//             // ),
//             Text(_auth.currentUser?.email ?? 'Avatar'),
//             const SizedBox(
//               height: 50,
//             ),
//             Container(
//               height: 40,
//               width: 200,
//               decoration: BoxDecoration(border: Border.all(width: 0.2)),
//               child: TextButton(
//                   style: const ButtonStyle(
//                       overlayColor: MaterialStatePropertyAll(
//                           Color.fromARGB(255, 207, 207, 207))),
//                   onPressed: () {},
//                   child: const Text(
//                     'Profili Düzenle',
//                     style: TextStyle(color: Colors.black),
//                   )),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(width: .2, color: Colors.grey)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       context.router.push(OrderRoute());
//                     },
//                     child: Container(
//                       width: 60,
//                       height: 64,
//                       child: const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon((Icons.shopping_bag_outlined)),
//                           Text(
//                             'Siparişler',
//                             style: TextStyle(fontSize: 12),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: .2, color: Colors.grey)),
//                     child: const SizedBox(
//                       height: 25,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     child: const SizedBox(
//                       width: 60,
//                       height: 64,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon((Icons.credit_card)),
//                           Text(
//                             'Kart',
//                             style: TextStyle(fontSize: 12),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: .2, color: Colors.grey)),
//                     child: const SizedBox(
//                       height: 25,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     child: const SizedBox(
//                       width: 60,
//                       height: 64,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon((Icons.event)),
//                           Text(
//                             'Etkinlikler',
//                             style: TextStyle(fontSize: 12),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: .2, color: Colors.grey)),
//                     child: const SizedBox(
//                       height: 25,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     child: const SizedBox(
//                       width: 60,
//                       height: 64,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon((Icons.settings)),
//                           Text(
//                             'Ayarlar',
//                             style: TextStyle(fontSize: 12),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ListView(
//               shrinkWrap: true,
//               children: const [
//                 ListTile(
//                   title: Text("GELEN KUTUSU"),
//                   subtitle: Text("2 mesaj"),
//                   trailing: Icon(Icons.chevron_right_outlined),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               onTap: () {
//                 FirebaseAuth.instance.signOut();
//                 context.router.replace(const LoginRoute());
//                 // _auth.currentUser != null;
//                 // authStore.isUserLoggedIn = false;

//                 showToast(message: "Successfully signed out");
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: 45,
//                 // width: 200,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.black, width: 1),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: const Center(
//                   child: Text(
//                     "Sign out",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: 30,
//               width: 250,
//               decoration: BoxDecoration(
//                   color: Colors.black12,
//                   borderRadius: BorderRadius.circular(10)),
//               child: const Text(
//                 'Aralık 2023 tarihinden beri üye',
//                 textAlign: TextAlign.center,
//               ),
//             )
//           ],
//         ),
//       ),
//     ));
//   }
// }
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  // final authStore = getIt.get<AuthStore>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // final autoStore = getIt.get<AuthStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),
      //   title: const Text('Profil'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // const SizedBox(
                //   height: 50,
                // ),
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    radius: 50,
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Text(
                  _auth.currentUser?.email ?? 'Avatar',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.grey)),
                  child: TextButton(
                      style: const ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 207, 207, 207))),
                      onPressed: () {},
                      child: const Text(
                        'Profili Düzenle',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: .2, color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: 60,
                          height: 64,
                          child: InkWell(
                            onTap: () {
                              context.router.push(OrderRoute());
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  (Icons.shopping_bag_outlined),
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Siparişler',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: .2, color: Colors.grey)),
                        child: const SizedBox(
                          height: 25,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const SizedBox(
                          width: 60,
                          height: 64,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                (Icons.credit_card),
                                color: Colors.grey,
                              ),
                              Text(
                                'Kart',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: .2, color: Colors.grey)),
                        child: const SizedBox(
                          height: 25,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const SizedBox(
                          width: 60,
                          height: 64,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                (Icons.event),
                                color: Colors.grey,
                              ),
                              Text(
                                'Etkinlikler',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: .2, color: Colors.grey)),
                        child: const SizedBox(
                          height: 25,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const SizedBox(
                          width: 60,
                          height: 64,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                (Icons.settings),
                                color: Colors.grey,
                              ),
                              Text(
                                'Ayarlar',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ListView(
                  shrinkWrap: true,
                  children: const [
                    ListTile(
                      titleTextStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      title: Text("GELEN KUTUSU"),
                      subtitleTextStyle: TextStyle(color: Colors.grey),
                      subtitle: Text("Mesajları görüntüle"),
                      trailing: Icon(Icons.chevron_right_outlined),
                    )
                  ],
                ),

                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    context.router.replace(const LoginRoute());

                    showToast(message: "Çıkış Yapıldı.");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        // width: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Çıkış Yap",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 35,
                    width: 365,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'Aralık 2023 tarihinden Beri Üye',
                        textAlign: TextAlign.center,
                        selectionColor: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
