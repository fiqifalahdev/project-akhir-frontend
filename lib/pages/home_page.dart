import 'package:flutter/material.dart';
import 'package:frontend_tambakku/util/styles.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Dapatkan akses informasi secara lengkap dan terhubung secara luas dengan pengepul dan pembudidaya Sidoarjo.",
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Montserrat',
              height: 1.5),
        ),
        const SizedBox(
          height: 15,
        ),
        // Appointment Request Features
        Container(
          width: MediaQuery.of(context).size.width,
          height: 159,
          padding: const EdgeInsets.only(left: 20, right: 15),
          decoration: BoxDecoration(
            color: CustomColors.putih,
            boxShadow: const [CustomColors.boxShadow],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Permintaan Pertemuan",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: CustomColors.primary,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Ajukan pertemuan dengan mudah melalui fitur Permintaan Pertemuan kami!",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // Appointment Request Features
        Container(
          width: MediaQuery.of(context).size.width + 200,
          height: 220,
          padding: const EdgeInsets.only(bottom: 20),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 150,
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 10, bottom: 5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CustomColors.putih,
                  boxShadow: const [CustomColors.boxShadow],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Riwayat Permintaan",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Pak Budi",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("08815018220",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 15, color: CustomColors.primary),
                            Text("Sidoarjo",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                          onPressed: () {},
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          label: const Text(
                            "Detail",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 15,
                            color: CustomColors.primary,
                          )),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 150,
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                ),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CustomColors.kuningGradient,
                  boxShadow: const [CustomColors.boxShadow],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: CustomColors.kuningMustard,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.emoji_people_rounded,
                          size: 40, color: CustomColors.putih),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Temui Pengepul",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(100, 30)),
                        ),
                        label: const Text("Cari Sekarang",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Montserrat')),
                        icon: const Icon(Icons.search_rounded,
                            size: 20, color: CustomColors.primary)),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
