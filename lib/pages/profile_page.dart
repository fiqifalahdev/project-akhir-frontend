import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/pages/add_product_page.dart';
import 'package:frontend_tambakku/pages/login_page.dart';
import 'package:frontend_tambakku/pages/update_profile_page.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:quickalert/quickalert.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool collapsedMenu = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collapsedMenu = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 400,
            decoration: const BoxDecoration(
                color: CustomColors.putih, boxShadow: [CustomColors.boxShadow]),
            child: customAppBar()),
        // Content Here
        Container(
          height: 500,
          color: Colors.amber,
        )
      ],
      // Cek apakah halaman Beranda?/Akun?/Peta?/Harga Ikan
    );
  }

  Widget customAppBar() {
    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(getBaseInfoProvider);
      print(data);
      return Padding(
        padding: const EdgeInsets.only(bottom: 19),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                bottom: 250,
                right: 0,
                child: Container(
                  // nanti kalo ada gambar maka ganti gambar
                  color: Colors.grey,
                )),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      collapsedMenu = !collapsedMenu;
                    });
                  },
                  icon: const Icon(Icons.more_vert_rounded),
                  color: CustomColors.putih,
                  iconSize: 25,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(CustomColors.primary),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                  )),
            ),
            Positioned(
                top: 140,
                left: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.name ?? "Pengguna",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data.role ?? "Pembudidaya",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
            Positioned(
              top: 70,
              right: 30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: CustomColors.darkBlue, width: 5)),
                child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(48),
                      child: data.profileImage == null
                          ? Image.asset(
                              "lib/assets/profile-avatar.jpg",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              // set the domain image
                              MainUtil().publicDomain + data.profileImage!,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
            ),
            Positioned(
                top: 200,
                left: 10,
                right: 10,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  // color: Colors.amber,
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Produk Unggulan : "),
                        // Produk ikan nanti disini
                        Text(
                          "- Ikan Nila Segar",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "- Bibit Ikan Nila",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "- Bandeng",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Button Navigation Profile //
                        // More button
                      ]),
                )),
            Positioned(
                top: 335,
                right: 10,
                child: Row(
                  children: [
                    // Button Tambah Produk
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddProductPage()));
                      },
                      icon:
                          const Icon(Icons.add, color: Colors.white, size: 20),
                      label: const Text("Tambah Produk",
                          style: TextStyle(
                              color: CustomColors.putih, fontSize: 14)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(CustomColors.primary),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            if (collapsedMenu)
              Positioned(
                top: 65,
                right: 10,
                child: Container(
                  width: 130,
                  height: 110,
                  decoration: BoxDecoration(
                      color: CustomColors.putih,
                      boxShadow: const [CustomColors.boxShadow],
                      borderRadius: BorderRadius.circular(10)),
                  child: menu(),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget menu() {
    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(getBaseInfoProvider);
      print(data);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: () {
              //   Nanti navigator push ke halaman edit profile
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProfilePage(data)));
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(CustomColors.primary),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 28),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
            icon: const Icon(
              Icons.edit,
              color: CustomColors.putih,
              size: 22,
            ),
            label: const Text("Edit",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton.icon(
            onPressed: () {
              ref.read(registrationProvider.notifier).logout().then((value) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Berhasil",
                  text: value ?? "Berhasil Keluar",
                  onConfirmBtnTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                );
              }).catchError((error) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Error",
                  text: "Terdapat Kesalahan pada Server!",
                );
              });
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )),
            icon: const Icon(
              Icons.logout_rounded,
              color: CustomColors.putih,
              size: 22,
            ),
            label: const Text(
              "Keluar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          )
        ],
      );
    });
  }
}
