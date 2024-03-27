import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/main_states.dart';
import 'package:frontend_tambakku/models/base_info.dart';
import 'package:frontend_tambakku/pages/home_page.dart';
import 'package:frontend_tambakku/pages/profile_page.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'dart:math' as math;

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  late int selectedIndex;

  final List<Widget> _page = [
    const Homepage(),
    const Center(child: Text("OKE")),
    const Center(child: Text("Harga Ikan")),
    const ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: selectedIndex == 0 ? customAppBar() : null,
      body: SingleChildScrollView(
          padding: selectedIndex != 3
              ? const EdgeInsets.symmetric(horizontal: 20.0)
              : const EdgeInsets.symmetric(horizontal: 0),
          // nanti wrap pake container
          child: Container(child: _page.elementAt(selectedIndex))),
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
                    selectedIndex == 0
                        ? Icons.home_filled
                        : Icons.home_outlined,
                    "Beranda",
                    0),
                buildNavItem(
                    selectedIndex == 1 ? Icons.map_rounded : Icons.map_outlined,
                    "Peta",
                    1),
                buildNavItem(
                    selectedIndex == 2
                        ? Icons.leaderboard_rounded
                        : Icons.leaderboard_outlined,
                    "Harga Ikan",
                    2),
                buildNavItem(
                    selectedIndex == 3
                        ? Icons.person_rounded
                        : Icons.person_outline,
                    "Akun",
                    3),
              ],
            )),
      ),
    ));
  }

  PreferredSizeWidget customAppBar() {

    final data = ref.watch(getUserDataProvider);

    return PreferredSize(
      preferredSize: const Size.fromHeight(138),
      child:  Padding(
          padding: const EdgeInsets.only(top: 38, left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selamat Datang,",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    data.name ?? "Pengguna",
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
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
        )
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        // Handle navigation when the item is tapped
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
