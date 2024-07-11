import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(bool focus)? onFocus;
  final Function(String value)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final VoidCallback? onSearch;
  final bool enabled;
  final double height;
  final String? hint;
  const CustomSearchBar(
      {Key? key,
      this.controller,
      this.onSearch,
      this.enabled = true,
      this.height = 48.0,
      this.onFocus,
      this.focusNode,
      this.hint,
      this.onSubmitted,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.grey[200]!,
      child: Focus(
        onFocusChange: onFocus,
        child: TextField(
          enabled: enabled,
          focusNode: focusNode,
          onSubmitted: onSubmitted,
          controller: controller,
          textInputAction: TextInputAction.search,
          onEditingComplete: onSearch,
          style: TextStyle(fontSize: 14),
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            border: InputBorder.none,
            isDense: true,
            suffixIcon: Icon(
              Icons.search_sharp,
              size: height / 1.5,
              color: Colors.black,
            ),
            hintText: hint ?? "Search",
            hintStyle:
                TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}
