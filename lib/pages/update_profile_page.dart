import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/models/base_info.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  final BaseInfo data;

  const UpdateProfilePage(this.data);

  @override
  ConsumerState<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  // Controller Form Update
  late TextEditingController nameController = TextEditingController(text: "");
  late TextEditingController emailController = TextEditingController(text: "");
  late TextEditingController phoneController = TextEditingController(text: "");
  late String genderController = "Laki-laki";
  late TextEditingController birthdateController =
      TextEditingController(text: "");
  late String roleController = "pembudidaya";
  late TextEditingController addressController =
      TextEditingController(text: "");
  late File profileImage;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        backgroundColor: CustomColors.primary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20,
          color: CustomColors.putih,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Stack(children: [
                Positioned(
                  top: 15,
                  left: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: CustomColors.primary, width: 5),
                        shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(48),
                          child: widget.data.profileImage == null
                              ? Image.asset(
                                  "lib/assets/profile-avatar.jpg",
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  MainUtil().publicDomain +
                                      widget.data.profileImage.toString(),
                                  fit: BoxFit.cover,
                                )),
                    ),
                  ),
                ),
                Positioned(
                    top: 93,
                    right: 120,
                    child: Consumer(builder: (context, ref, child) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: CustomColors.primary, width: 3),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            // Get Image
                            // Update Image

                            await ref.read(fileProvider.notifier).pickImage();
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          style: const ButtonStyle(
                            iconColor: MaterialStatePropertyAll<Color?>(
                                CustomColors.primary),
                          ),
                        ),
                      );
                    })),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            // Form Update disini
            formUpdate(),
            // const SizedBox(
            //   height: 500,
            // )
          ],
        ),
      ),
    ));
  }

  Widget formUpdate() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        formLabel("Nama"),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: const BorderSide(width: 5),
                borderRadius: BorderRadius.circular(8)),
            hintText: widget.data.name ?? "Nama Anda",
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        formLabel("Nomor HP"),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: const BorderSide(width: 5),
                borderRadius: BorderRadius.circular(8)),
            hintText: widget.data.phone ?? "Nomor HP Anda",
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        formLabel("Email"),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: const BorderSide(width: 5),
                borderRadius: BorderRadius.circular(8)),
            hintText: widget.data.email ?? "Email Anda",
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        formLabel("Tanggal Lahir"),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: birthdateController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            hintText: DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(widget.data.birthdate)) ??
                "DD-MM-YYYY",
            hintStyle: const TextStyle(fontSize: 16),
            suffixIcon: IconButton(
                onPressed: () async {
                  final value = await showDatePicker(context);

                  if (value != null) {
                    birthdateController.text =
                        DateFormat("dd-MM-yyyy").format(value[0]!);
                  }
                },
                icon: const Icon(Icons.calendar_today)),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Tanggal Lahir tidak boleh kosong";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        formLabel("Gender"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            child: DropdownButtonFormField(
          hint: Text(widget.data.gender ?? "Pilih Jenis Kelamin"),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: "Laki-laki",
              child: Text("Laki-laki"),
            ),
            DropdownMenuItem(
              value: "Perempuan",
              child: Text("Perempuan"),
            ),
          ],
          onChanged: (value) {
            genderController = value.toString();
          },
          validator: (value) {
            if (value == null) {
              return "Jenis Kelamin tidak boleh kosong";
            }
          },
        )),
        const SizedBox(
          height: 10,
        ),
        formLabel("Peran"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            child: DropdownButtonFormField(
          hint: Text(widget.data.role ?? "Pilih Peran"),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: "pembudidaya",
              child: Text("pembudidaya"),
            ),
            DropdownMenuItem(
              value: "pengepul",
              child: Text("pengepul"),
            ),
          ],
          onChanged: (value) {
            roleController = value.toString();
          },
          validator: (value) {
            if (value == null) {
              return "Peran anda tidak boleh kosong";
            }
          },
        )),
        const SizedBox(
          height: 10,
        ),
        formLabel("Alamat"),
        const SizedBox(height: 10),
        TextFormField(
            controller: addressController,
            maxLines: 5,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 5),
                    borderRadius: BorderRadius.circular(8)),
                hintText: widget.data.address ?? "Masukkan Alamat Anda")),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                isLoading = true;

                // Cek Data
                profileImage = ref.watch(fileProvider);
              });
              // // Update Data set data dengan Provider
              if (nameController.text.isNotEmpty ||
                  phoneController.text.isNotEmpty ||
                  emailController.text.isNotEmpty ||
                  birthdateController.text.isNotEmpty ||
                  genderController.isNotEmpty ||
                  roleController.isNotEmpty ||
                  addressController.text.isNotEmpty ||
                  profileImage.path.isNotEmpty) {
                // hit API update profile ke backend

                String token = ref.watch(tokenProvider).when(
                    data: (data) => data,
                    error: (error, stackTrace) => error.toString(),
                    loading: () => "Loading");

                ref.read(getBaseInfoProvider.notifier).updateProfile({
                  "name": nameController.text.isEmpty
                      ? widget.data.name
                      : nameController.text,
                  "phone": phoneController.text.isEmpty
                      ? widget.data.phone
                      : phoneController.text,
                  "email": emailController.text.isEmpty
                      ? widget.data.email
                      : emailController.text,
                  "birthdate": birthdateController.text.isEmpty
                      ? widget.data.birthdate
                      : birthdateController.text,
                  "gender": genderController.isEmpty
                      ? widget.data.gender
                      : genderController,
                  "role": roleController.isEmpty
                      ? widget.data.role
                      : roleController,
                  "address": addressController.text.isEmpty
                      ? widget.data.address
                      : addressController.text,
                  "profile_image": profileImage.path.isEmpty
                      ? widget.data.profileImage
                      : profileImage
                }, token).then((value) {
                  setState(() {
                    isLoading = false;
                  });

                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: "Berhasil",
                      text: "Profil berhasil diubah");

                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Layout()));
                  });
                });
              }
            },
            style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll<Color?>(
                    CustomColors.primary),
                minimumSize: MaterialStatePropertyAll<Size>(
                    Size(MediaQuery.of(context).size.width, 55)),
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
            child: isLoading
                ? LoadingAnimationWidget.discreteCircle(
                    color: CustomColors.putih, size: 25)
                : const Text(
                    "Ubah Profil",
                    style: TextStyle(
                        color: CustomColors.putih,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  )),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }

  Text formLabel(String label) {
    return Text(label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16));
  }

  // =========================
  // Show Calendar Date Picker
  // =========================

  Future<List<DateTime?>?> showDatePicker(BuildContext context) async {
    return await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
          selectedDayHighlightColor: CustomColors.primary,
          calendarType: CalendarDatePicker2Type.single),
      dialogBackgroundColor: Colors.white,
      dialogSize: const Size(325, 400),
      value: [DateTime.now()],
      borderRadius: BorderRadius.circular(8),
    );
  }
}
