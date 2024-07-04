import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/components/badge_info.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:intl/intl.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final String image;
  final String caption;
  final int id;
  final String createdAt;

  const ProductDetailsPage(
      {super.key,
      required this.image,
      required this.caption,
      required this.id,
      required this.createdAt});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          leadingWidth: 50,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey[50],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
            iconSize: 30,
            color: CustomColors.darkBlue,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width - 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          boxShadow: const [CustomColors.boxShadow],
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(
                                  MainUtil().publicDomain + widget.image),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: BadgeInfo(
                        content: DateFormat("dd-MM-yyyy")
                            .format(DateTime.parse(widget.createdAt)),
                        color: CustomColors.lightBlue.withOpacity(0.2),
                        style: TextStyle(
                            fontSize: 16.0,
                            color: CustomColors.primary.withOpacity(0.8),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Deskripsi Gambar : ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Text(widget.caption, style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
