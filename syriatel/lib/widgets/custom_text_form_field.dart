import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/size_config.dart'; // تأكد من المسار الصحيح

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final double x;
  final double y;
  final TextInputType? inputType;
  final IconData? prefix;
  final int? maxLines;
  final IconData? suffix;
  final Function? pss;
  final FormFieldValidator? validator;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.x = 0,
    this.y = 0,
    this.inputType,
    this.prefix,
    this.suffix,
    this.maxLines,
    this.pss,
    this.validator
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.labelText!,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF888888),
          ),
        ),
         SizedBox(height: SizeConfig.scaleHeight(16)),
        // Text Field Container
        Container(
          width: SizeConfig.scaleWidth(327),
          height: SizeConfig.scaleHeight(70),


          child: TextFormField(

            keyboardType: widget.inputType,
            validator: widget.validator,
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            obscureText: widget.obscureText,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              prefixIcon: widget.prefix != null
                  ? Icon(widget.prefix, color: Color(0xFF888888))
                  : null,
              suffixIcon: widget.suffix != null
                  ? IconButton(
                onPressed: () {
                  widget.pss?.call();
                },
                icon: Icon(widget.suffix, color: Color(0xFF888888)),
              )
                  : null,

              // الحواف لحالات مختلفة
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(32)),
                borderSide: BorderSide(color:Colors.grey.shade400) ,),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(32)),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(32)),
                borderSide: BorderSide(color: Colors.red,),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(32)),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              filled: false,
              isCollapsed: false,
              contentPadding:  EdgeInsets.symmetric(vertical: SizeConfig.scaleHeight(12)),
            ),

          ),
        )

      ],
    );
  }
}
