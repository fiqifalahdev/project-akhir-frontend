import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/pages/profile_page.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  late TextEditingController captionController = TextEditingController();
  late File imageFile = File('');
  final _formKey = GlobalKey<FormState>();

  bool isImagePicked = false;
  bool isLoading = false;

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
              // Dispose the state file
              // if (ref.watch(fileProvider).path.isNotEmpty) {
              //   ref.read(fileProvider.notifier).dispose();
              // }
              if (imageFile.path.isNotEmpty ||
                  captionController.text.isNotEmpty ||
                  isImagePicked) {
                ref.invalidate(fileProvider);
              }

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
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Postingan Baru",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold)),

                        const SizedBox(height: 20),
                        // =============== Pick Image ===============
                        const Text("Pilih Gambar",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),

                        DottedBorder(
                          dashPattern: const [3, 3, 3, 3],
                          borderType: BorderType.RRect,
                          child: InkWell(
                            onTap: () {
                              ref.read(fileProvider.notifier).pickImage();

                              // Check if image is picked
                              setState(() {
                                isImagePicked = true;
                              });
                            }, // Nanti Pilih Gambar disini
                            child: isImagePicked || imageFile.path.isNotEmpty
                                ? Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        boxShadow: const [
                                          CustomColors.boxShadow
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: FileImage(
                                                ref.watch(fileProvider)),
                                            fit: BoxFit.cover)),
                                  )
                                : Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        boxShadow: const [
                                          CustomColors.boxShadow
                                        ],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Center(
                                      child: Text(
                                          "Klik disini untuk memilih gambar",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16)),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Caption Postingan",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: captionController,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Judul Postingan',
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 5),
                                borderRadius: BorderRadius.circular(8)),
                            hintStyle: const TextStyle(color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Caption tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Kirim Postingan Produk
                        // print("Caption: ${captionController.text}");
                        // print("Image: ${ref.watch(fileProvider).path}");

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;

                            imageFile = ref.watch(fileProvider);
                          });

                          ref
                              .read(feedProvider.notifier)
                              .postFeed(captionController.text, imageFile)
                              .then((value) {
                            // print(value);
                            QuickAlert.show(
                              type: QuickAlertType.success,
                              context: context,
                              title: "Berhasil",
                              text: "Postingan berhasil dikirim",
                              onConfirmBtnTap: () {
                                print("OKE");
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );

                            // Navigate Profile Page
                            ref.invalidate(fileProvider);
                            ref.invalidate(feedProvider);

                            captionController.clear();
                          }).onError((error, stackTrace) {
                            // print("error: $error");
                            // print("stackTrace: $stackTrace");
                            QuickAlert.show(
                              type: QuickAlertType.error,
                              context: context,
                              title: "Gagal",
                              text: error.toString(),
                            );
                          }).whenComplete(() {
                            setState(() {
                              isLoading = false;
                            });
                          });
                          // }).catchError((error) {
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: LoadingAnimationWidget.discreteCircle(
                                  color: CustomColors.putih, size: 30))
                          : const Text("Kirim Postingan Produk",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
