import 'package:flutter/material.dart';

import 'package:rideztohealth/core/extensions/text_extensions.dart';
import '../../../../core/widgets/wide_custom_button.dart';
import '../widgets/outlined_text_field_widget copy.dart';

class EditProfile extends StatefulWidget {
  //final UserforProfile userProfile;

  // const EditProfile({super.key, required this.userProfile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  // nameController = TextEditingController(text: widget.userProfile.name ?? '');
  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color(0xFF438B92),
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: Color(0xffB0E0CF), // light gray-blue background
          body: Stack(
            children: [
              // Top background image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0.0, 25.0),
                      ),
                    ],
                  ),
                  child:
                      //NetworkImage(),
                      Image.asset(
                        'assets/images/bg.png', // path to your image
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 145, // adjust height as needed
                      ),
                ),
              ),

              // Page content
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App bar title
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          'My Profile'.text20Black(),
                          Text('          '),
                        ],
                      ),
                    ),
                  ),
                  // Profile Section
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 0,
                      left: 16,
                      right: 16,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(
                                  0,
                                  2,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(
                                        0,
                                        2,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child:
                                    // widget.userProfile.avatar != null &&
                                    //         widget
                                    //             .userProfile
                                    //             .avatar!
                                    //             .isNotEmpty
                                    // ? Image.network(
                                    //   widget.userProfile.avatar!,
                                    //   width: 170,
                                    //   height: 170,
                                    //   fit: BoxFit.cover,
                                    //   errorBuilder:
                                    //       (context, error, stackTrace) =>
                                    //           Image.asset(
                                    //             'assets/images/person.png',
                                    //             width: 170,
                                    //             height: 170,
                                    //             fit: BoxFit.cover,
                                    //           ),
                                    // )
                                    //:
                                    Image.asset(
                                      'assets/images/person.png',
                                      width: 170,
                                      height: 170,
                                      fit: BoxFit.cover,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              //(

                              //widget.userProfile.name ??

                              //'Mr. User Name')
                              'Mr. User Name'.text24Black(),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 120,
                          bottom: 0,
                          left: 170,

                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/icons/iconsEdit.png',
                              // fit: BoxFit.fitWidth,
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Name'.text14Black(),
                          const SizedBox(height: 4),

                          OutlinedTextFieldforProfileWidget(
                            isIconshow: true,
                            controller: nameController,
                            textInputType: TextInputType.text,
                            // icon: Icon(Icons.insert_drive_file_outlined),
                          ),
                          // OutlinedTextFieldWidget(
                          //   controller: nameController,
                          //   textInputType: TextInputType.text,
                          // ),
                          const SizedBox(height: 16),
                          WideCustomButton(text: 'Update', onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
