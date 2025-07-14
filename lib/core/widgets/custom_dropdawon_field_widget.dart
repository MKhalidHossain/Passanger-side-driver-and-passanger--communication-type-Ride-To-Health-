
import 'package:flutter/material.dart';
import 'package:rideztohealth/core/utils/constants/app_colors.dart';

class CustomDropdownFieldWidget<T> extends StatelessWidget {
  //final String label;
  final text;
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final hinttext;

  const CustomDropdownFieldWidget({
    super.key,
    // required this.label,
    this.text,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.validator,
    this.hinttext = 'Select',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 7),
        SizedBox(
          height: 40,
          child: DropdownButtonFormField<T>(
            hint: Text(
              hinttext,
              style: TextStyle(color: AppColors.context(context).textColor),
            ),
            value: value,
            decoration: InputDecoration(
              //labelText: label,
              labelStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: AppColors.context(context).fillColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColors.context(context).borderColor,
                ),
              ),
            ),
            dropdownColor: AppColors.context(context).contentBoxGreyColor,
            iconEnabledColor: AppColors.context(context).textColor,
            style: TextStyle(color: Colors.white, fontSize: 13),
            items:
                items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: TextStyle(
                        color: AppColors.context(context).textColor,
                      ),
                    ),
                  );
                }).toList(),
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// class CustomDropdawonFieldWidget extends StatefulWidget {
//   const CustomDropdawonFieldWidget({super.key});

//   @override
//   State<CustomDropdawonFieldWidget> createState() =>
//       _CustomDropdawonFieldWidgetState();
// }

// class _CustomDropdawonFieldWidgetState
//     extends State<CustomDropdawonFieldWidget> {
//   @override
//   var _currencies = [
//     "Food",
//     "Transport",
//     "Personal",
//     "Shopping",
//     "Medical",
//     "Rent",
//     "Movie",
//     "Salary",
//   ];
//   Widget build(BuildContext context) {
//     return FormField<String>(
//       builder: (FormFieldState<String> state) {
//         return InputDecorator(
//           decoration: InputDecoration(
//             labelStyle: textStyle,
//             errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
//             hintText: 'Please select expense',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//           ),
//           isEmpty: _currentSelectedValue == '',
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               value: _currentSelectedValue,
//               isDense: true,
//               onChanged: (String newValue) {
//                 setState(() {
//                   _currentSelectedValue = newValue;
//                   state.didChange(newValue);
//                 });
//               },
//               items:
//                   _currencies.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
