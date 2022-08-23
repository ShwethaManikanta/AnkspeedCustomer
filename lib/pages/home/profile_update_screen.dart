import 'package:flutter/material.dart';
import 'package:new_ank_customer/Services/apiProvider/registration_api_provider.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/common/utils.dart';
import 'package:provider/provider.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  String _dropDownValue = "";

  final nameKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final emailKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final phoneNumberKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();

  @override
  void initState() {
    if (context.read<ProfileViewAPIProvider>().profileViewResponse == null) {
      context.read<ProfileViewAPIProvider>().fetchData();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileAPIProvider = Provider.of<ProfileViewAPIProvider>(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(
              0,
              0.5,
            ),
            end: Alignment(
              0.9999999999999999,
              0.4999999910767653,
            ),
            colors: [
              ColorConstant.whiteA700,
              ColorConstant.whiteA700,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (nameKey.currentState!.validate() &&
                        emailKey.currentState!.validate()) {
                      if (nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty ||
                          nameController.text !=
                              profileAPIProvider
                                  .profileViewResponse!.userDetails!.userName ||
                          emailController.text !=
                              profileAPIProvider
                                  .profileViewResponse!.userDetails!.email) {
                        await apiServices
                            .updateProfile(
                                userName: nameController.text.isEmpty
                                    ? profileAPIProvider.profileViewResponse!
                                        .userDetails!.userName!
                                    : nameController.text,
                                userEmail: emailController.text.isEmpty
                                    ? profileAPIProvider.profileViewResponse!
                                        .userDetails!.email!
                                    : emailController.text,
                                userPhoneNumber: profileAPIProvider
                                    .profileViewResponse!.userDetails!.mobile!)
                            .whenComplete(() {
                          Navigator.pop(context);
                          context.read<ProfileViewAPIProvider>().fetchData();
                        });
                      } else {
                        Utils.showSnackBar(
                            context: context,
                            text: "Check your Profile Details");
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: ColorConstant.green400,
                      borderRadius: BorderRadius.circular(
                        10.00,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.black90040,
                          spreadRadius: 2.00,
                          blurRadius: 2.00,
                          offset: Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                    child: Text(
                      "Save",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorConstant.whiteA700,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Mobile number",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstant.black900,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  profileAPIProvider.profileViewResponse!.userDetails!.mobile!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.black900,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Cannot be changed.",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.black900,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: ColorConstant.whiteA700,
                borderRadius: BorderRadius.circular(
                  20.00,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.black90040,
                    spreadRadius: 2.00,
                    blurRadius: 2.00,
                    offset: Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: nameKey,
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                          hintText:
                              "${profileAPIProvider.profileViewResponse!.userDetails!.userName}"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: emailKey,
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                          hintText:
                              "${profileAPIProvider.profileViewResponse!.userDetails!.email}"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  /*Text(
                    "GST Details",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton(
                          underline: null,
                          hint: _dropDownValue == null
                              ? Text('Dropdown')
                              : Text(
                                  _dropDownValue,
                                  style: TextStyle(color: Colors.black),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: ["Not Available", "Available"].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _dropDownValue = val.toString();
                              },
                            );
                          },
                        ),
                      )),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
