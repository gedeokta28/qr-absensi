import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_absensi/static/colors.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final Widget? iconText;
  final String placeholder;
  final bool isSecure;
  final bool isError;
  final TextEditingController controller;
  final FormFieldValidator? fieldValidator;
  final TextInputType inputType;
  final bool refresh;
  final Function? onTap;
  final String? suffixText;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final bool border;
  final Function? onChanged;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final bool enablePadding;
  final bool isRounded;
  final EdgeInsets padding;
  final int maxLine;

  const CustomTextField(
      {Key? key,
      this.placeholder = '',
      this.title,
      this.iconText,
      this.isSecure = false,
      this.isError = false,
      required this.controller,
      required this.fieldValidator,
      this.inputType = TextInputType.text,
      this.refresh = false,
      this.onTap,
      this.suffixText,
      this.border = false,
      this.onChanged,
      this.enabled = true,
      this.inputFormatters,
      this.enablePadding = false,
      this.isRounded = false,
      this.maxLine = 1,
      this.prefixWidget,
      this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      this.suffixWidget})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _passwordVisible;

  late OutlineInputBorder normalBorder;
  late OutlineInputBorder enabledBorder;

  late OutlineInputBorder errorBorder;

  late OutlineInputBorder roundErrorBorder;

  late OutlineInputBorder roundBorder;

  @override
  void initState() {
    _passwordVisible = widget.isSecure;
    normalBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      borderSide: BorderSide(
        width: 1.5,
        color: widget.border ? borderColor : Colors.white,
      ),
    );
    enabledBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      borderSide: BorderSide(
        color: widget.border ? Colors.black : Colors.white,
      ),
    );

    roundBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(style: BorderStyle.solid),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title section
        widget.title != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.iconText != null ? widget.iconText! : Container(),
                  Text(
                    widget.title ?? "",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 8.0),
        // Input field section
        TextFormField(
          maxLines: widget.maxLine,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          onTap: () {
            if (widget.refresh) {
              widget.onTap!();
            }
          },
          onChanged: (str) {
            if (widget.onChanged != null) widget.onChanged!();
          },
          obscureText: _passwordVisible,
          controller: widget.controller,
          keyboardType: widget.inputType,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            disabledBorder: normalBorder,
            focusColor: Colors.white,
            hintText: widget.placeholder,
            hintStyle: TextStyle(fontSize: 14, color: greyText),
            border: normalBorder,
            enabledBorder: normalBorder,
            focusedBorder: enabledBorder,
            filled: true,
            fillColor: Colors.white,
            contentPadding: widget.padding,
            prefixIcon: widget.prefixWidget,
            suffixIcon: widget.isSecure
                ? Material(
                    color: Colors.transparent,
                    child: IconButton(
                        color: greyText,
                        splashRadius: 20.0,
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(_passwordVisible
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded)),
                  )
                : widget.suffixText != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.suffixText!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          ),
                        ],
                      )
                    : widget.suffixWidget,
          ),
          validator: widget.fieldValidator,
        ),
      ],
    );
  }
}
