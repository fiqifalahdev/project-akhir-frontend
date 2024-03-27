import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/main_states.dart';
import 'package:frontend_tambakku/models/base_info.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'dart:math' as math;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        // Container(
        //   height: 500,
        // )
      ],
      // Cek apakah halaman Beranda?/Akun?/Peta?/Harga Ikan
    );
  }

  Widget customAppBar() {
    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(getUserDataProvider);
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
                          IconButton(onPressed: () {
                          //   Nanti navigator push ke halaman edit profile
                          }, icon: const Icon(Icons.edit, color: CustomColors.primary))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data.role ?? "Pembudidaya",
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                      child:
                      data.profile_image == null
                          ? Image.asset(
                              "lib/assets/profile-avatar.jpg",
                              fit: BoxFit.cover,
                            )
                          :
                      Image.asset( // fetch gambar dari storage laravel
                              "lib/assets/petambak.jpg",
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Produk Unggulan : "),
                        // Produk ikan nanti disini
                        const Text(
                          "- Ikan Nila Segar",
                          style: TextStyle(fontSize: 12),
                        ),
                        const Text(
                          "- Bibit Ikan Nila",
                          style: TextStyle(fontSize: 12),
                        ),
                        const Text(
                          "- Bandeng",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // Button Navigation Profile //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.location_on_outlined,
                                color: CustomColors.primary,
                                size: 20,
                              ),
                              label: const Text(
                                "Lihat Lokasi",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              style: ButtonStyle(
                                  padding: const MaterialStatePropertyAll<
                                          EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5)),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                  shape: MaterialStatePropertyAll<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {},
                                style: ButtonStyle(
                                    padding: const MaterialStatePropertyAll<
                                            EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5)),
                                    backgroundColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.white),
                                    shape: MaterialStatePropertyAll<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)))),
                                icon: const Icon(
                                  Icons.event_available,
                                  color: CustomColors.primary,
                                  size: 20,
                                ),
                                label: const Text(
                                  "Buat Pertemuan",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ))
                          ],
                        ),
                      ]),
                )),
          ],
        ),
      );
    });
  }
}
