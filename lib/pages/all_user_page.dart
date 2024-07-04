import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/components/user_details_bottomsheets.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AllUserPage extends ConsumerStatefulWidget {
  const AllUserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllUserPageState();
}

class _AllUserPageState extends ConsumerState<AllUserPage> {
  void _getAllUser() async {
    ref.read(allUserProvider.notifier).getAllUser();
  }

  void _launchWhatsApp(String phone) async {
    final whatsappUrl = "whatsapp://send?phone=$phone";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Couldn't open WhatsApp")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Semua Pengguna',
          style: TextStyle(color: CustomColors.putih),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: CustomColors.putih),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: CustomColors.darkBlue,
      ),
      body: ListView.builder(
          itemCount: ref.watch(allUserProvider).length,
          itemBuilder: (context, index) {
            final allUser = ref.watch(allUserProvider);
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allUser[index]['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        allUser[index]['email'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        allUser[index]['role'] == "pembudidaya"
                            ? "Pembudidaya"
                            : "Pengepul",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        allUser[index]['phone'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref.read(userIdProvider.notifier).update(
                                (state) => state = allUser[index]['id']);

                            showFlexibleBottomSheet(
                              context: context,
                              builder: (context, scrollController,
                                      bottomSheetOffset) =>
                                  UserDetailBottomSheet(
                                scrollController: scrollController,
                                bottomSheetOffset: bottomSheetOffset,
                              ),
                            );
                          },
                          icon: const Icon(Icons.description,
                              color: Colors.white),
                          label: const Text("Details",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ) // WhatsApp color
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
