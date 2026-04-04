import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class NewTextField extends StatefulWidget {
  final TextInputType? inputType;
  final IconData? prefix;
  final ValueSetter? onSaved;
  final int? maxLines;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String? lText;
  final String hText;
  final ValueChanged<String> onChanged;
  final IconData? suffix;
  final bool? isPassword;
  final Function? pss;


  NewTextField({
    required this.inputType,
    this.prefix,
    this.suffix,
    this.onSaved,
    required this.onChanged,
    this.maxLines,
    required this.controller,
    required this.validator,
    required this.hText,
    this.lText,
    this.isPassword=false,
    this.pss,

  });

  @override
  State<NewTextField> createState() => _NewTextFieldState();
}

class _NewTextFieldState extends State<NewTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(14),
        child:
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.inputType,
          obscureText: widget.isPassword!,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            labelText: widget.lText,
            hintText: widget.hText,
            prefixIcon: Icon(widget.prefix),
            errorStyle: TextStyle(color: Colors.purple),
            suffixIcon:

            IconButton(
              icon:

              Icon(widget.suffix),
              onPressed: (){
                widget.pss!();
              },
            ),
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
              borderSide: BorderSide(

              ),
            ),
          ),
        ));
  }
}
