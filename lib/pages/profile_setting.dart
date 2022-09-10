import 'package:flutter/material.dart';
import 'package:new_ank_customer/Services/apiProvider/registration_api_provider.dart';
import 'package:new_ank_customer/backend/service/firebase_auth_service.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/common/loading_widget.dart';
import 'package:new_ank_customer/pages/signIn/sign_in_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../Services/api_services.dart';
import '../common/utils.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  // ProfileViewRespones? profileViewRespones;
  @override
  void initState() {
    super.initState();
    getData();
    // if (profileViewRespones == null) {
    // }
  }

  late PackageInfo? packageInfo;

  final nameKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final emailKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final phoneNumberKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  bool _packageInfoLoaded = false;

  void getData() async {
    // ProfileViewRequest profileViewRequest = ProfileViewRequest(userId: 1);
    // apiServices.profileViewRequest(profileViewRequest).then((value) {
    //   setState(() {
    //     profileViewRespones = value;
    //   });
    // });

    if (context.read<ProfileViewAPIProvider>().profileViewResponse == null) {
      context.read<ProfileViewAPIProvider>().fetchData().whenComplete(() {
        nameController.text = context
            .read<ProfileViewAPIProvider>()
            .profileViewResponse!
            .userDetails!
            .userName!;
        emailController.text = context
            .read<ProfileViewAPIProvider>()
            .profileViewResponse!
            .userDetails!
            .email!;
        phoneNumberController.text = context
            .read<ProfileViewAPIProvider>()
            .profileViewResponse!
            .userDetails!
            .mobile!;
      });
    } else {
      nameController.text = context
          .read<ProfileViewAPIProvider>()
          .profileViewResponse!
          .userDetails!
          .userName!;
      emailController.text = context
          .read<ProfileViewAPIProvider>()
          .profileViewResponse!
          .userDetails!
          .email!;
      phoneNumberController.text = context
          .read<ProfileViewAPIProvider>()
          .profileViewResponse!
          .userDetails!
          .mobile!;
    }
    packageInfo = await PackageInfo.fromPlatform().whenComplete(() {
      setState(() {
        _packageInfoLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileViewAPIProvider>(context);

    return Scaffold(
      body: SizedBox(height: deviceHeight(context) * 0.92, child: buildBody()),
      appBar: buildAppbar(),
    );
  }

  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  buildAppbar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 88, 26, 22),
      leading: const SizedBox(),
      centerTitle: true,
      title: Text(
        'Profile',
        style: CommonStyles.whiteText16BoldW500(),
      ),
    );
  }

  Widget buildBody() {
    final profileViewAPIProvider = Provider.of<ProfileViewAPIProvider>(context);
    if (profileViewAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (profileViewAPIProvider.error) {
      return SizedBox(
        height: 400,
        width: 300,
        child: Utils.showErrorMessage(profileViewAPIProvider.errorMessage),
      );
    } else if (profileViewAPIProvider.profileViewResponse == null ||
        profileViewAPIProvider.profileViewResponse!.status! == "0") {
      return Utils.showErrorMessage(
          profileViewAPIProvider.profileViewResponse!.message!);
    }

    return SingleChildScrollView(
      child: Column(children: [
        // buildProfile(),
        buildUserDetails(),
        // buildSizedbox(),
        buildAccount(),
      ]),
    );
  }

  buildUserDetails() {
    final profileViewAPIProvider = Provider.of<ProfileViewAPIProvider>(context);
    if (profileViewAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (profileViewAPIProvider.error) {
      return SizedBox(
        height: 400,
        width: 300,
        child: Utils.showErrorMessage(
            profileViewAPIProvider.errorMessage.toUpperCase()),
      );
    } else if (profileViewAPIProvider.profileViewResponse == null ||
        profileViewAPIProvider.profileViewResponse!.status! == "0") {
      return Utils.showErrorMessage(
          profileViewAPIProvider.profileViewResponse!.message!.toUpperCase());
    }
    final user = profileViewAPIProvider.profileViewResponse!;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.userDetails!.userName!,
                style: CommonStyles.blue18900(),
                textAlign: TextAlign.right,
              ),
              // AnimatedTextKit(
              //   animatedTexts: [
              //     ColorizeAnimatedText('${user.userDetails!.userName}',
              //         textStyle: CommonStyles.black57S18(),
              //         textAlign: TextAlign.right,
              //         colors: colorizeColors)
              //   ],
              // ),
              MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      clipBehavior: Clip.none,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.clear,
                                            size: 20,
                                            color: Colors.deepOrange,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        Text(
                                          'EDIT PROFILE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontSize: 17.0,
                                                  color: Colors.blueAccent),
                                        )
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Colors.deepOrange,
                                      ),
                                      onPressed: () async {
                                        if (nameKey.currentState!.validate() &&
                                            emailKey.currentState!.validate() &&
                                            phoneNumberKey.currentState!
                                                .validate()) {
                                          await apiServices
                                              .updateProfile(
                                                  userName: nameController.text,
                                                  userEmail:
                                                      emailController.text,
                                                  userPhoneNumber:
                                                      phoneNumberController
                                                          .text)
                                              .whenComplete(() {
                                            Navigator.pop(context);

                                            context
                                                .read<ProfileViewAPIProvider>()
                                                .fetchData();
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // ListTile(
                              //   leading:
                              //   title: ,
                              //   trailing:
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, left: 8.0, right: 8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Form(
                                        key: nameKey,
                                        child: TextFormField(
                                          controller: nameController,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              labelText: "User name",
                                              labelStyle: CommonStyles
                                                  .blackw54s9Thin()),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Form(
                                        key: emailKey,
                                        child: TextFormField(
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Email",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Form(
                                        key: phoneNumberKey,
                                        child: TextFormField(
                                          readOnly: true,
                                          controller: phoneNumberController,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.length < 10) {
                                              return 'Not Valid Phone Number.';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Mobile",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                color: Colors.brown,
                height: 34,
                padding: EdgeInsets.zero,
                highlightColor: Colors.blue.withOpacity(0.6),
                splashColor: Colors.blue.withOpacity(0.6),
                visualDensity: VisualDensity.compact,
                minWidth: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 0.4,
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          //
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // user!.userDetails!.customerName == null ||
              //         user.userDetails!.customerName == ""
              //     ? Text(
              //         'No name',
              //         style: Theme.of(context).textTheme.headline6!.copyWith(
              //             fontWeight: FontWeight.bold, fontSize: 18.0),
              //       )
              //     :

              Row(
                children: [
                  Text(
                    // profileViewRespones!.data.name.toUpperCase(),
                    user.userDetails!.mobile!,
                    style: CommonStyles.black12(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green[800], shape: BoxShape.circle),
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Center(
                          child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      )),
                    ),
                  )
                ],
              ),
              Utils.getSizedBox(height: 10),
              Row(
                children: [
                  Text(
                    // profileViewRespones!.data.name.toUpperCase(),
                    user.userDetails!.email!,
                    style: CommonStyles.black12(),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.green[800], shape: BoxShape.circle),
                  //   child: const Padding(
                  //     padding: EdgeInsets.all(3.0),
                  //     child: Center(
                  //         child: Icon(
                  //       Icons.check,
                  //       color: Colors.white,
                  //       size: 14,
                  //     )),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildSizedbox() {
    return const SizedBox(
      height: 45,
    );
  }

  buildAccount() {
    final profileViewAPIProvider = Provider.of<ProfileViewAPIProvider>(context);
    if (profileViewAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (profileViewAPIProvider.error) {
      return SizedBox(
        height: 400,
        width: 300,
        child: Utils.showErrorMessage(
            profileViewAPIProvider.errorMessage.toUpperCase()),
      );
    } else if (profileViewAPIProvider.profileViewResponse == null ||
        profileViewAPIProvider.profileViewResponse!.status! == "0") {
      return Utils.showErrorMessage(
          profileViewAPIProvider.profileViewResponse!.message!.toUpperCase());
    }
    final user = profileViewAPIProvider.profileViewResponse!;

    return Column(
      // physics: BouncingScrollPhysics(),
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Utils.getSizedBox(height: 10),
            /* SizedBox(
              width: deviceWidth(context),
              child: Image.network(
                profileViewAPIProvider.profileViewResponse!.bannerBaseurl! +
                    profileViewAPIProvider
                        .profileViewResponse!.adminDetails!.bannerImage!,
                width: deviceWidth(context),
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Header Text",
                    style: CommonStyles.blue18900(),
                  ),
                  Utils.getSizedBox(height: 5),
                  SizedBox(
                    width: deviceWidth(context),
                    child: Text(
                      profileViewAPIProvider
                          .profileViewResponse!.adminDetails!.description!,
                      style: CommonStyles.black11(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

        MaterialButton(
          // elevation: 10,
          padding: EdgeInsets.zero,
          onPressed: () async {
            print("______Logout Button Pressed ________________");

            var dialog = CustomAlertDialog(
                title: "Logout",
                message: "Are you sure, do you want to logout?",
                onPostivePressed: () async {
                  final firebaseAuthService =
                      Provider.of<FirebaseAuthService>(context, listen: false);
                  showLoading(context);
                  await firebaseAuthService.signOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SignInPage()));
                },
                positiveBtnText: 'Yes',
                negativeBtnText: 'No');
            showDialog(
                context: context, builder: (BuildContext context) => dialog);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.logout,
                  size: 20,
                  color: Colors.brown,
                ),
                Utils.getSizedBox(width: 10),
                Text(
                  'LogOut',
                  style: CommonStyles.black15(),
                )
              ],
            ),
          ),
        ),
        if (_packageInfoLoaded)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.info,
                  size: 20,
                  color: Colors.brown,
                ),
                Utils.getSizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Version',
                      style: CommonStyles.black13(),
                    ),
                    Text(
                      packageInfo!.version,
                      style: CommonStyles.black1254thin(),
                    ),
                  ],
                )
              ],
            ),
          ),
        // Visibility(
        //   child:
        //   visible: _packageInfoLoaded,
        // )

        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Row(
        //     children: [
        //       Container(
        //         alignment: Alignment.topLeft,
        //         height: 55,
        //         width: 55,
        //         child: const Center(
        //           child: Icon(
        //             Icons.settings,
        //             color: Colors.white,
        //             size: 35,
        //           ),
        //         ),
        //         decoration: BoxDecoration(
        //           color: const Color.fromARGB(255, 88, 26, 22),
        //           borderRadius: BorderRadius.circular(15),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black.withOpacity(.3),
        //               blurRadius: 25.0,
        //               spreadRadius: 1.0,
        //               offset: const Offset(
        //                 5.0,
        //                 10.0,
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       const SizedBox(
        //         width: 15,
        //       ),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: const [
        //             Text(
        //               'Account',
        //               style: TextStyle(
        //                   fontSize: 18, fontWeight: FontWeight.w800),
        //             ),
        //             Text(
        //               'Edit a Profile And Manage Your Account Details ',
        //               style: TextStyle(
        //                   fontSize: 10, fontWeight: FontWeight.w400),
        //             ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Container(
        //     child: Padding(
        //       padding: const EdgeInsets.all(15.0),
        //       child: Column(
        //         children: [
        //           TextFormField(
        //             readOnly: false,
        //             keyboardType: TextInputType.multiline,
        //             maxLines: null,
        //             initialValue: "myname@gmail.com",
        //             style: CommonStyles.black12(),
        //             decoration: InputDecoration(
        //                 isDense: true,
        //                 labelStyle: TextStyle(
        //                     color: Colors.green.shade800,
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.w600),
        //                 labelText: 'E-mail',
        //                 border: InputBorder.none),
        //           ),
        //           SizedBox(
        //             height: 5,
        //           ),
        //           TextFormField(
        //             readOnly: false,
        //             keyboardType: TextInputType.multiline,
        //             maxLines: null,
        //             initialValue: "987678987",
        //             //  profileViewRespones!.data.mobile,
        //             style: TextStyle(
        //                 fontSize: 18, fontWeight: FontWeight.w500),
        //             decoration: InputDecoration(
        //                 isDense: true,
        //                 labelStyle: TextStyle(
        //                     color: Colors.green.shade800,
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.w600),
        //                 labelText: 'Mobile Number',
        //                 border: InputBorder.none),
        //           ),
        //         ],
        //       ),
        //     ),
        //     decoration: BoxDecoration(
        //         color: Colors.blueGrey[100],
        //         borderRadius: BorderRadius.circular(10)),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Row(
        //     children: [
        //       Container(
        //         alignment: Alignment.topLeft,
        //         height: 55,
        //         width: 55,
        //         child: const Center(
        //           child: Icon(
        //             Icons.mail_outline,
        //             color: Colors.white,
        //             size: 35,
        //           ),
        //         ),
        //         decoration: BoxDecoration(
        //           color: const Color.fromARGB(255, 88, 26, 22),
        //           borderRadius: BorderRadius.circular(15),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black.withOpacity(.3),
        //               blurRadius: 25.0,
        //               spreadRadius: 1.0,
        //               offset: const Offset(
        //                 5.0,
        //                 10.0,
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Help and Feedback',
        //             style: TextStyle(
        //                 fontSize: 18, fontWeight: FontWeight.w800),
        //           ),
        //           Text(
        //             'Reach us with your feedback and questions ',
        //             style: TextStyle(
        //                 fontSize: 10, fontWeight: FontWeight.w400),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Container(
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             'FAQ and Video',
        //           ),
        //           SizedBox(
        //             height: 10,
        //           ),
        //           Text(
        //             'Contact Us',
        //           ),
        //         ],
        //       ),
        //     ),
        //     decoration: BoxDecoration(
        //         color: Colors.blueGrey[100],
        //         borderRadius: BorderRadius.circular(10)),
        //   ),
        // ),
        // GestureDetector(
        //   onTap: () async {
        //     print("______Logout Button Pressed ________________");
        //     final firebaseAuthService =
        //         Provider.of<FirebaseAuthService>(context, listen: false);
        //     showLoading(context);
        //     await firebaseAuthService.signOut();
        //     Navigator.of(context).pop();
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => const SignInPage()));
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Container(
        //       alignment: Alignment.center,
        //       height: 50,
        //       width: 150,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10),
        //         color: const Color.fromARGB(255, 88, 26, 22),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.black.withOpacity(.3),
        //             blurRadius: 25.0,
        //             spreadRadius: 1.0,
        //             offset: const Offset(
        //               5.0,
        //               10.0,
        //             ),
        //           )
        //         ],
        //       ),
        //       child: const Text(
        //         'LogOut',
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 25,
        //             fontWeight: FontWeight.w700),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final String? message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final Function? onPostivePressed;
  final Function? onNegativePressed;
  final double? circularBorderRadius;

  const CustomAlertDialog(
      {this.title,
      this.message,
      this.circularBorderRadius = 15.0,
      this.bgColor = Colors.white,
      this.positiveBtnText,
      this.negativeBtnText,
      this.onPostivePressed,
      this.onNegativePressed,
      Key? key})
      : assert(bgColor != null),
        assert(circularBorderRadius != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              style: CommonStyles.black16(),
            )
          : null,
      content: message != null
          ? Text(
              message!,
              style: CommonStyles.black1154(),
            )
          : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius!)),
      buttonPadding: EdgeInsets.only(top: 12, right: 4),
      actions: <Widget>[
        negativeBtnText != null
            ? MaterialButton(
                child: Text(
                  negativeBtnText!,
                  style: CommonStyles.black57S14(color: Colors.green[900]),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNegativePressed != null) {
                    onNegativePressed!();
                  }
                },
              )
            : const SizedBox(),
        positiveBtnText != null
            ? MaterialButton(
                child: Text(
                  positiveBtnText!,
                  style: CommonStyles.black57S14(color: Colors.red[900]),
                ),
                onPressed: () {
                  if (onPostivePressed != null) {
                    onPostivePressed!();
                  }
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
