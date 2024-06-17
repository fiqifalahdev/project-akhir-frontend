import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/components/accept_reject_button.dart';
import 'package:frontend_tambakku/components/badge_info.dart';
import 'package:frontend_tambakku/components/loading_widget.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/helpers.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:quickalert/quickalert.dart';

class IncomingRequestPage extends ConsumerStatefulWidget {
  const IncomingRequestPage({super.key});

  @override
  ConsumerState<IncomingRequestPage> createState() =>
      _IncomingRequestPageState();
}

class _IncomingRequestPageState extends ConsumerState<IncomingRequestPage> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(incomingRequestProvider.notifier).getIncomingRequest();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColors.darkBlue,
            title: const Text(
              "Permintaan Masuk",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Center(
            child: ref.watch(incomingRequestProvider).isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_rounded,
                          size: 100, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "Tidak ada permintaan masuk",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        margin: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          itemCount: ref.watch(incomingRequestProvider).length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
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
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png'),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            ref.watch(incomingRequestProvider)[
                                                index]['requester']['name'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ref.watch(incomingRequestProvider)[
                                                            index]['requester']
                                                        ['role'] ==
                                                    'pembudidaya'
                                                ? 'Pembudidaya'
                                                : 'Pengepul',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            ref.watch(incomingRequestProvider)[
                                                index]['requester']['email'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      BadgeInfo(
                                        content: ref.watch(
                                                incomingRequestProvider)[index]
                                            ['appointment_date'],
                                        color: CustomColors.lightBlue
                                            .withOpacity(0.2),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: CustomColors.primary
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w600),
                                        icon: const Icon(
                                            Icons.calendar_month_rounded,
                                            size: 15,
                                            color: CustomColors.primary),
                                      ),
                                      const SizedBox(width: 10),
                                      BadgeInfo(
                                        content: Helpers().removeSeconds(
                                            ref.watch(incomingRequestProvider)[
                                                index]['appointment_time']),
                                        color: CustomColors.lightBlue
                                            .withOpacity(0.2),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: CustomColors.primary
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w600),
                                        icon: const Icon(
                                            Icons.access_time_filled,
                                            size: 15,
                                            color: CustomColors.primary),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      UpdateButton(
                                          status: 1,
                                          appointmentId: ref.watch(
                                                  incomingRequestProvider)[
                                              index]['appointment_id']),
                                      const SizedBox(width: 10),
                                      UpdateButton(
                                          status: 0,
                                          appointmentId: ref.watch(
                                                  incomingRequestProvider)[
                                              index]['appointment_id']),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          )),
    );
  }
}
