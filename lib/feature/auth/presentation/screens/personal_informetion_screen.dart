import 'package:flutter/material.dart';
import 'package:rideztohealth/core/common/button/button_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import 'tourist_or_local_screen.dart';

class PersonalInformetionScreen extends StatefulWidget {
  const PersonalInformetionScreen({super.key});

  @override
  State<PersonalInformetionScreen> createState() => UserSignupScreenState();
}

class UserSignupScreenState extends State<PersonalInformetionScreen> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      appBar: AppBar(
        
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: size.height),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Name
                        RichText(
                          text: TextSpan(
                            text: 'First Name',
                            style: TextStyle(
                              color: AppColors.context(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hint: Text('Write your first name here. . .', style: TextStyle(color: AppColors.secondayText),)
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// Name
                        RichText(
                          text: TextSpan(
                            text: 'Last Name',
                            style: TextStyle(
                              color: AppColors.secondayText,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hint: Text('Write your last name here. . .', style: TextStyle(color: AppColors.secondayText),)
                          ),
                        ),

                        const SizedBox(height: 12),
                        RichText(
                          text: TextSpan(
                            text: 'Age',
                            style: TextStyle(
                              color: AppColors.secondayText,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hint: Text('Write your last name here. . .', style: TextStyle(color: AppColors.secondayText),) 
                          ),
                        ),
                        const SizedBox(height: 12),

                        // RichText(
                        //   text: TextSpan(
                        //     text: 'Gender',
                        //     style: TextStyle(
                        //       color: AppColors.secondayText,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //     children: [
                        //       TextSpan(
                        //         text: ' *',
                        //         style: TextStyle(
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.w700,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //     hint: 'Select your nation'.bodyLarge(
                        //       color: AppColors.secondayText,
                        //     ),
                        //   ),
                        // ),
                        //_buildGenderDropdown(),
                       const SizedBox(height: 12),

                        /// Login button
                        context.primaryButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TouristORLocal(),
                              ),
                            );
                          },
                          text: "Continue",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





//  Widget _buildGenderDropdown() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Gap.h12,
//         Text('Gender', style: TextStyle(color: Colors.grey)),
//         Gap.h4,
//         Container(
//           decoration: BoxDecoration(
//             color: AppColors.primaryColor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: DropdownButtonFormField<String>(
//             value: selectedGender,
//             onChanged: isEditing
//                 ? (val) => setState(() => selectedGender = val)
//                 : null,
//             dropdownColor: Colors.grey[900],
//             icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
//             style: TextStyle(color: Colors.white, fontSize: 16),
//             decoration: const InputDecoration(
//               hintText: 'Set a gender',
//               hintStyle: TextStyle(color: Colors.grey),
//               border: InputBorder.none,
//               enabledBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(vertical: 14),
//             ),
//             items: ['Male', 'Female', 'Other']
//                 .map(
//                   (gender) => DropdownMenuItem<String>(
//                     value: gender,
//                     child: Text(gender, style: TextStyle(color: Colors.white)),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }