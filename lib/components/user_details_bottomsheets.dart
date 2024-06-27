import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/components/custom_date_timeline_picker.dart';
import 'package:frontend_tambakku/components/loading_widget.dart';
import 'package:frontend_tambakku/components/time_option_button.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

///
/// This class is used to call a details of a user and show it in a bottom sheet
/// @params scrollController : ScrollController
/// @params bottomSheetOffset : double
///
/// @return userDetail : Widget
///

class UserDetailBottomSheet extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final double bottomSheetOffset;

  const UserDetailBottomSheet(
      {super.key,
      required this.scrollController,
      this.bottomSheetOffset = 0.0});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserDetailBottomSheetState();
}

class _UserDetailBottomSheetState extends ConsumerState<UserDetailBottomSheet> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(userIdProvider);

    final userDetail = ref.watch(getUserDetailProvider(details)).when(
      data: (data) {
        final details = data['detail'];
        final feeds = data['feeds'];

        return SafeArea(
          child: Container(
              decoration: const BoxDecoration(
                color: CustomColors.putih,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(controller: widget.scrollController, children: [
                // ======================== App bar ========================
                Container(
                  color: CustomColors.putih,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= User Profile =====================
                      Container(
                        padding: const EdgeInsets.only(
                            top: 18, left: 18, right: 18, bottom: 10),
                        decoration: BoxDecoration(
                          color: CustomColors.putih,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(2, 4),
                                spreadRadius: 2,
                                blurRadius: 10)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: CustomColors.darkBlue,
                                          width: 5)),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                        size: const Size.fromRadius(48),
                                        child:
                                            //data.profileImage == null
                                            Image.network(
                                                "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png")
                                        // : Image.network(
                                        //     // set the domain image
                                        //     MainUtil().publicDomain +
                                        //         data.profileImage!,
                                        //     fit: BoxFit.cover,
                                        //   )),
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${details['name'] ?? "Nama User"}",
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.darkBlue),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${details['role'] ?? "Peran User"} - ${details['gender'] ?? "Laki-laki"}",
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: CustomColors.darkBlue),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (details['about'] != null) ...[
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${details['about']}",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: CustomColors.blackOpacity),
                              ),
                            ],
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    "Alamat : ${details['address'] ?? "Alamat User"}",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: CustomColors.blackOpacity,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      ExpansionTile(
                          title: const Text(
                            "Buat Janji Temu",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          tilePadding: const EdgeInsets.all(8),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          childrenPadding: const EdgeInsets.only(left: 8),
                          children: [
                            const Text("Tanggal",
                                style: TextStyle(
                                    color: CustomColors.darkBlue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700)),
                            // ================= Date =====================
                            const CustomDateTimeline(),
                            const SizedBox(height: 15),
                            // ================= Time =====================
                            const Text("Waktu",
                                style: TextStyle(
                                    color: CustomColors.darkBlue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700)),
                            // ================= Row Of Button ====================
                            appointmentTimeOption(),
                            const SizedBox(height: 15),
                            // Send Button
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: isLoading
                                  ? Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: CustomColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: LoadingAnimationWidget
                                            .discreteCircle(
                                                color: CustomColors.putih,
                                                size: 30),
                                      ),
                                    )
                                  : ElevatedButton.icon(
                                      onPressed: () async {
                                        print("Ajukan Janji Temu");
                                        print(ref.watch(selectedDateProvider));
                                        print(ref.watch(selectedTimeProvider));

                                        final res = ref
                                            .read(sendAppointmentProvider
                                                .notifier)
                                            .sendAppointment();

                                        setState(() {
                                          isLoading = true;
                                        });

                                        res.then((value) {
                                          if (value.isNotEmpty) {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.success,
                                              title: "Berhasil",
                                              text: value,
                                            );

                                            // Nanti redirect ke halaman appointment dia

                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        }).onError((error, stackTrace) {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: "Error",
                                            text: error.toString(),
                                          );

                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                CustomColors.primary),
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                                const Size(100, 40)),
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      label: const Text(
                                        "Ajukan Janji Temu",
                                        style: TextStyle(
                                          color: CustomColors.putih,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      icon: const Icon(Icons.event,
                                          color: Colors.white),
                                    ),
                            ),
                          ]),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: GridView.builder(
                      itemCount: feeds.length,
                      itemBuilder: (context, index) {
                        // Render Feed Image
                        return InkWell(
                          onTap: () {
                            print("Masuk Ke detail Produk");
                          },
                          child: Image.network(
                            MainUtil().publicDomain + feeds[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                    ),
                  ),
                ),
              ])),
        );
      },
      error: (error, stackTrace) {
        print("Stacktrace : $stackTrace");

        return Center(
          child: Text("Error: $error"),
        );
      },
      loading: () {
        return loadingWidget();
      },
    );

    return userDetail;
  }

  void _toggleSelection(String time) {
    if (ref.watch(selectedTimeProvider) == time) {
      ref.read(selectedTimeProvider.notifier).state = "";
    } else {
      ref.read(selectedTimeProvider.notifier).state = time;
    }
  }

  Widget appointmentTimeOption() {
    return Container(
      padding: const EdgeInsets.only(top: 8, right: 8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TimeOptionButton(
                time: "08:00",
                isSelected: ref.watch(selectedTimeProvider) == "08:00",
                onSelected: () => _toggleSelection("08:00"),
              ),
              const SizedBox(width: 8),
              TimeOptionButton(
                time: "09:00",
                isSelected: ref.watch(selectedTimeProvider) == "09:00",
                onSelected: () => _toggleSelection("09:00"),
              ),
              const SizedBox(width: 8),
              TimeOptionButton(
                time: "10:00",
                isSelected: ref.watch(selectedTimeProvider) == "10:00",
                onSelected: () => _toggleSelection("10:00"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TimeOptionButton(
                time: "15:00",
                isSelected: ref.watch(selectedTimeProvider) == "15:00",
                onSelected: () => _toggleSelection("15:00"),
              ),
              const SizedBox(width: 8),
              TimeOptionButton(
                time: "16:00",
                isSelected: ref.watch(selectedTimeProvider) == "16:00",
                onSelected: () => _toggleSelection("16:00"),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
