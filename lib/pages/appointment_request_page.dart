import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/components/badge_info.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/helpers.dart';
import 'package:frontend_tambakku/util/styles.dart';

class AppointmentPage extends ConsumerStatefulWidget {
  const AppointmentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppointmentPageState();
}

class _AppointmentPageState extends ConsumerState<AppointmentPage>
    with TickerProviderStateMixin {
  // Variables
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  void getAppointments() async {
    await ref.read(sendAppointmentProvider.notifier).getAppointment();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppointments();
  }

  TabBar tabBar() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(
          child: Text("Menunggu", style: TextStyle(color: Colors.black)),
        ),
        Tab(
          child: Text("Diterima", style: TextStyle(color: Colors.black)),
        ),
        Tab(child: Text("Ditolak", style: TextStyle(color: Colors.black))),
      ],
      indicatorColor: CustomColors.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.darkBlue,
          title: const Text(
            "Janji Temu Anda",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          // bottom: tabBar(),
        ),
        body: Column(
          children: [
            tabBar(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                appointmentByItsStatus("pending"),
                appointmentByItsStatus("accepted"),
                appointmentByItsStatus("rejected")
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget appointmentByItsStatus(String status) {
    final requesterData = ref.watch(getBaseInfoProvider);

    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var appointment in ref.watch(appointments)) ...[
              if (appointment['status'] == status) ...[
                Container(
                  padding: const EdgeInsets.only(
                      top: 18, left: 18, right: 18, bottom: 10),
                  margin: const EdgeInsets.only(bottom: 10),
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
                                    color: CustomColors.darkBlue, width: 5)),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                  size: const Size.fromRadius(48),
                                  child:
                                      //data.profileImage == null
                                      Image.asset(
                                    "lib/assets/profile-avatar.jpg",
                                    fit: BoxFit.cover,
                                  )
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
                                "${appointment['recipient']['name']}",
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.darkBlue),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${appointment['recipient']['role'] ?? "Pembudidaya"} - ${appointment['recipient']['gender'] ?? "Laki-laki"}",
                                // "${details['role'] ?? "Peran User"} - ${details['gender'] ?? "Laki-laki"}",
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: CustomColors.darkBlue),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("${appointment['recipient']['address'] ?? "Alamat"}",
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: CustomColors.darkBlue,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (status == "pending" || status == "accepted")
                            Row(
                              children: [
                                BadgeInfo(
                                  content: "${appointment['appointment_date']}",
                                  color:
                                      CustomColors.lightBlue.withOpacity(0.2),
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color:
                                          CustomColors.primary.withOpacity(0.8),
                                      fontWeight: FontWeight.w600),
                                  icon: const Icon(Icons.calendar_month_rounded,
                                      size: 15, color: CustomColors.primary),
                                ),
                                const SizedBox(width: 10),
                                BadgeInfo(
                                  content: Helpers().removeSeconds(
                                      "${appointment['appointment_time']}"),
                                  color:
                                      CustomColors.lightBlue.withOpacity(0.2),
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color:
                                          CustomColors.primary.withOpacity(0.8),
                                      fontWeight: FontWeight.w600),
                                  icon: const Icon(Icons.access_time_filled,
                                      size: 15, color: CustomColors.primary),
                                ),
                              ],
                            ),
                          if (status == "pending") ...[
                            TextButton.icon(
                                onPressed: () {
                                  Helpers().launchWhatsapp(
                                      appointment['recipient']['phone'],
                                      "Halo, Saya dari ${requesterData.name} ingin membuat janji temu dengan Anda, pada tanggal ${appointment['appointment_date']} jam ${appointment['appointment_time']}");
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color(0xff25d366).withOpacity(0.2)),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(80, 30)),
                                ),
                                icon: const Icon(
                                  Icons.sms_rounded,
                                  size: 15,
                                  color: Color(0xff128c7e),
                                ),
                                label: const Text(
                                  "Hubungi",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff25d366),
                                      fontWeight: FontWeight.bold),
                                )),
                          ] else if (status == "accepted") ...[
                            TextButton.icon(
                                onPressed: () {},
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          CustomColors.primary),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(80, 30)),
                                ),
                                icon: const Icon(
                                  Icons.directions,
                                  size: 15,
                                  color: CustomColors.putih,
                                ),
                                label: const Text(
                                  "Rute",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: CustomColors.putih,
                                      fontWeight: FontWeight.bold),
                                )),
                          ] else ...[
                            TextButton.icon(
                                onPressed: () {},
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      CustomColors.primary.withOpacity(0.2)),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(80, 30)),
                                ),
                                icon: const Icon(
                                  Icons.calendar_month,
                                  size: 15,
                                  color: CustomColors.primary,
                                ),
                                label: const Text(
                                  "Jadwalkan Ulang",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: CustomColors.primary,
                                      fontWeight: FontWeight.bold),
                                )),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ]
            ]
          ],
        ),
      ),
    );
  }
}
