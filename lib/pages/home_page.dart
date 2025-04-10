import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/components/badge_info.dart';
import 'package:frontend_tambakku/components/user_details_bottomsheets.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/helpers.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Consumer(builder: (context, ref, child) {
        final latest = ref.watch(latestAppointment);
        final requester = latest['requester'];

        print("Requester $requester");
        print("Latest $latest");

        return RefreshIndicator(
          onRefresh: () async {
            Future.delayed(const Duration(seconds: 5), () {});

            final token = ref.watch(tokenProvider);

            ref.read(getBaseInfoProvider.notifier).getBaseInfo(token);

            ref.read(incomingRequestProvider.notifier).getIncomingRequest();

            ref.watch(latestAppointment);

            ref.invalidate(latestAppointment);
            ref.invalidate(incomingRequestProvider);

            print("Refresh OK");

            setState(() {});
          },
          child: Container(
            height: 500,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    // Headline Text
                    const Text(
                      "Dapatkan akses informasi secara lengkap dan terhubung secara luas dengan pengepul dan pembudidaya Sidoarjo.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          height: 1.5),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        homepageFeatures(
                          imageAssets: 'lib/assets/ringbell.png',
                          label: "Daftar Permintaan Masuk",
                          value: "${ref.watch(appointmentSumProvider)}",
                          color: CustomColors.pastelBlu,
                          opacity: 0.3,
                          onPressed: () =>
                              Navigator.pushNamed(context, '/incoming-request'),
                        ),
                        homepageFeatures(
                            imageAssets: 'lib/assets/calendar-2.png',
                            label: "Permintaan Saya",
                            color: CustomColors.pastelGreen,
                            opacity: 0.3,
                            onPressed: () => Navigator.pushNamed(
                                context, '/my-appointment')),
                      ],
                    ),
                    // Appointment Request Features
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     homepageFeatures(
                    //         imageAssets: 'lib/assets/location-pin.png',
                    //         label: "Temui Pembudidaya",
                    //         color: CustomColors.pastelYellow,
                    //         opacity: 0.3,
                    //         onPressed: () => Navigator.pushNamed(context, '/maps')),
                    //     homepageFeatures(
                    //         imageAssets: 'lib/assets/user-regis.png',
                    //         label: "Lihat Semua Pengguna",
                    //         color: CustomColors.pastelPink,
                    //         opacity: 0.3,
                    //         onPressed: () =>
                    //             Navigator.pushNamed(context, '/all-user')),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: CustomColors.pastelMediumLightBlu,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [CustomColors.boxShadow],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: -5,
                              right: -5,
                              child: Image.asset(
                                'lib/assets/quickly.png',
                                opacity: const AlwaysStoppedAnimation(0.3),
                              )),
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Janji temu yang akan datang",
                                    style: TextStyle(
                                        color: CustomColors.darkBlue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  requester == null
                                      ? const Text(
                                          "Tidak ada janji temu yang akan datang")
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${requester['name']}",
                                                  style: const TextStyle(
                                                      color:
                                                          CustomColors.darkBlue,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const Text(
                                                  " - ",
                                                  style: TextStyle(
                                                      color:
                                                          CustomColors.darkBlue,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  requester['role'] ==
                                                          'pembudidaya'
                                                      ? 'Pembudidaya'
                                                      : 'Pengepul',
                                                  style: const TextStyle(
                                                      color:
                                                          CustomColors.darkBlue,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                BadgeInfo(
                                                  content:
                                                      "${latest['appointment_date']}",
                                                  color: CustomColors.primary,
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: CustomColors.putih,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  icon: const Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      size: 15,
                                                      color:
                                                          CustomColors.putih),
                                                ),
                                                const SizedBox(width: 10),
                                                BadgeInfo(
                                                  content: Helpers().removeSeconds(
                                                      "${latest['appointment_time']}"),
                                                  color: CustomColors.primary,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: CustomColors.putih
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  icon: const Icon(
                                                      Icons.access_time_filled,
                                                      size: 15,
                                                      color:
                                                          CustomColors.putih),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                TextButton.icon(
                                                    onPressed: () {
                                                      // redirect to whatsapp chat
                                                      print(
                                                          "Requester Phone ${requester['phone']}");

                                                      Helpers().launchWhatsapp(
                                                          "08815018220",
                                                          "Halo, saya dari ${requester['name']}. Saya ingin mengonfirmasi janji temu kita pada tanggal ${latest['appointment_date']} pukul ${Helpers().removeSeconds(latest['appointment_time'])}");
                                                    },
                                                    style: ButtonStyle(
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all<
                                                                      Color>(
                                                                  CustomColors
                                                                      .putih),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<
                                                                      Color>(
                                                                  const Color(
                                                                      0xff25d366)),
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all<
                                                                      Size>(
                                                                  const Size(
                                                                      80, 30)),
                                                    ),
                                                    icon: const Icon(
                                                      Icons.sms_rounded,
                                                      size: 15,
                                                      color: CustomColors.putih,
                                                    ),
                                                    label: const Text(
                                                      "Hubungi",
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          // color: Color(0xff25d366),
                                                          color: CustomColors
                                                              .putih,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        )
                                ],
                              ))
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: CustomColors.darkBlue,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/all-user');
                            },
                            child: const Text(
                              "Lihat Semua Pengguna",
                              style: TextStyle(
                                  color: CustomColors.darkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                const Text("Rekomendasi Pengguna",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    children: [
                      for (var user in ref.watch(homepageUserProvider)) ...[
                        // ListTile
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(vertical: 5),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          "${MainUtil().publicDomain}${user['profile_image'] ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'}"),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user['name'],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.darkBlue,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          user['email'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          user['role'] == "pembudidaya"
                                              ? "Pembudidaya"
                                              : "Pengepul",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      ref.read(userIdProvider.notifier).update(
                                          (state) => state = user['id']);

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
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded))
                              ],
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildUserInfo({required String label, required TextStyle style}) {
    return Text(
      label,
      style: style,
    );
  }

  Widget homepageFeatures(
      {required String imageAssets,
      required String label,
      String? value,
      required Color color,
      required double opacity,
      required void Function() onPressed}) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) * 0.5,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [CustomColors.boxShadow],
      ),
      child: Stack(children: [
        Positioned(
          bottom: -10,
          right: -10,
          child: Image.asset(
            imageAssets,
            opacity: AlwaysStoppedAnimation(opacity),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value ?? "",
                    style: const TextStyle(
                        color: CustomColors.darkBlue,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      onPressed: onPressed,
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: CustomColors.darkBlue,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                label,
                style: const TextStyle(
                    color: CustomColors.darkBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
