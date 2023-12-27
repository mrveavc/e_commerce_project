import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';
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
  final authStore = getIt.get<AuthStore>();

  final autoStore = getIt.get<AuthStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //       onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),
        //   title: const Text('Profil'),
        // ),
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
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
            Text(autoStore.currentUSer?.email ?? 'Avatar'),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(border: Border.all(width: 0.2)),
              child: TextButton(
                  style: const ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 207, 207, 207))),
                  onPressed: () {},
                  child: const Text(
                    'Profili Düzenle',
                    style: TextStyle(color: Colors.black),
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
                    child: Container(
                      width: 60,
                      height: 64,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon((Icons.shopping_bag_outlined)),
                          Text(
                            'Siparişler',
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
                          Icon((Icons.credit_card)),
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
                          Icon((Icons.event)),
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
                          Icon((Icons.settings)),
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
            const SizedBox(
              height: 20,
            ),
            ListView(
              shrinkWrap: true,
              children: const [
                ListTile(
                  title: Text("GELEN KUTUSU"),
                  subtitle: Text("2 mesaj"),
                  trailing: Icon(Icons.chevron_right_outlined),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                context.router.replace(const LoginRoute());
                authStore.isUserLoggedIn = false;

                showToast(message: "Successfully signed out");
              },
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
                    "Sign out",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Aralık 2023 tarihinden beri üye',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
