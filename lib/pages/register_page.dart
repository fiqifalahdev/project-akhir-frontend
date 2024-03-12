import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _credentialFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _personalDataFormKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  late String gender;

  bool passwordIsVisible = false;
  bool passwordConfirmationIsVisible = false;
  bool dateIsVisible = false;

  late int step; // nanti simpan ke state management

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    step = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "lib/assets/register-bg.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 50, left: 15),
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                ),
              ),
            ),
            step == 1 ? credentialsForm() : personalDataForm(),
            Positioned(
              top: MediaQuery.of(context).size.height - 100,
              child: Row(
                children: [
                  Container(
                    width: step == 1 ? 50 : 20,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          step == 1 ? CustomColors.primary : Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: step == 1 ? 20 : 50,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          step == 1 ? Colors.grey[300] : CustomColors.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height - 55,
                child: step == 1 ? nextButton() : prevNextButton()),
            // Additional widgets can be added here if needed
          ],
        ),
      ),
    );
  }

  Widget nextButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      color: CustomColors.primary,
      child: TextButton(
        onPressed: () {
          // if (_credentialFormKey.currentState!.validate()) {
          //   setState(() {
          //     step = 2;
          //   });
          // }
          if (step == 1) {
            setState(() {
              step = 2;
            });
          }
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Lanjut",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white)),
            SizedBox(width: 15),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20)
          ],
        ),
      ),
    );
  }

  Widget prevNextButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 55,
            child: TextButton(
                onPressed: (() {
                  setState(() {
                    step = 1;
                  });
                }),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios,
                        color: CustomColors.primary, size: 20),
                    Text("Kembali",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: CustomColors.darkBlue)),
                  ],
                )),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              color: CustomColors.primary,
              height: 55,
              child: TextButton(
                onPressed: () {
                  print("OKE");
                  // Set isLoading to true
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Daftar",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: CustomColors.putih)),
                    SizedBox(width: 15),
                    Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 20)
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // =========================
  // Required Data credentials
  // =========================
  Widget credentialsForm() {
    return Positioned(
      top: 80,
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _credentialFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Daftar",
                  style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              // Nama Lengkap
              const Text("Nama Lengkap",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: "Masukkan Nama Lengkap Anda",
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nama tidak boleh kosong";
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 15),
              const Text("Email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              // Email
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: "Masukkan Email Anda",
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              const Text("Kata Sandi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: password,
                  obscureText: !passwordIsVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: "Masukkan Kata Sandi Anda",
                    hintStyle: const TextStyle(fontSize: 16),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordIsVisible = !passwordIsVisible;
                        });
                      },
                      icon: Icon(passwordIsVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kata Sandi tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              const Text("Konfirmasi Kata Sandi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              SizedBox(
                height: 55,
                child: TextFormField(
                  obscureText: !passwordConfirmationIsVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: "Masukkan Konfirmasi Kata Sandi Anda",
                    hintStyle: const TextStyle(fontSize: 16),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordConfirmationIsVisible =
                              !passwordConfirmationIsVisible;
                        });
                      },
                      icon: Icon(passwordConfirmationIsVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Konfirmasi Kata Sandi tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // Additional Personal Data
  // =========================
  Widget personalDataForm() {
    return Positioned(
      top: -100,
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _personalDataFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Daftar",
                    style:
                        TextStyle(fontSize: 37, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                const Text("Nomor Telepon",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: "Masukkan Nomor Telepon",
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nomor Telepon tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                const Text("Gender",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                // Dropdown
                SizedBox(
                    child: DropdownButtonFormField(
                  hint: const Text("Pilih Jenis Kelamin"),
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
                    gender = value.toString();
                  },
                )),
                const SizedBox(height: 15),
                const Text("Tanggal Lahir",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: birthdate,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: "DD/MM/YYYY",
                    hintStyle: const TextStyle(fontSize: 16),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final value = await showDatePicker(context);

                          if (value != null) {
                            birthdate.text =
                                DateFormat("dd/MM/yyyy").format(value[0]!);
                          }
                        },
                        icon: const Icon(Icons.calendar_today)),
                  ),
                ),
                // Date Picker
              ],
            )),
      ),
    );
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
