import 'package:flutter/material.dart';
import 'package:frontend_tambakku/pages/home_page.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'dart:math' as math;

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late int selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(138),
        child:
            customAppBar(), // Cek apakah halaman Beranda?/Akun?/Peta?/Harga Ikan?
      ),
      body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          // nanti wrap pake container
          child: Homepage()),
      bottomNavigationBar: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 69,
            margin: const EdgeInsets.only(bottom: 20, left: 18, right: 18),
            decoration: BoxDecoration(
              color: CustomColors.putih,
              boxShadow: const [CustomColors.boxShadow],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(
                    selectedIndex == 1
                        ? Icons.home_filled
                        : Icons.home_outlined,
                    "Beranda",
                    1),
                buildNavItem(
                    selectedIndex == 2 ? Icons.map_rounded : Icons.map_outlined,
                    "Peta",
                    2),
                buildNavItem(
                    selectedIndex == 3
                        ? Icons.leaderboard_rounded
                        : Icons.leaderboard_outlined,
                    "Harga Ikan",
                    3),
                buildNavItem(
                    selectedIndex == 4
                        ? Icons.person_rounded
                        : Icons.person_outline,
                    "Akun",
                    4),
              ],
            )),
      ),
    ));
  }

  Widget customAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 38, left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang,",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "Yusuf",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
          Transform.rotate(
            angle: 17 * math.pi / 180,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  size: 40,
                  color: CustomColors.primary,
                )),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        // Handle navigation when the item is tapped
        print("Masok");

        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selectedIndex != index
                ? CustomColors.teksAbu
                : CustomColors.primary,
            size: 25,
          ),
          // Adjust the spacing between icon and label
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color:
                  selectedIndex != index ? CustomColors.teksAbu : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
