import 'package:flutter/material.dart';

class CustomLogoutDialog extends StatelessWidget {
  final Function positiveAction;
  const CustomLogoutDialog({Key? key, required this.positiveAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      withPadding: true,
      withMargin: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Text(
              "Anda ingin keluar dari akun ini ? ",
              style: TextStyle(fontSize: 15.0),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ConfirmationButtons(
            positiveAction: positiveAction,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class ConfirmationButtons extends StatelessWidget {
  final Function positiveAction;
  const ConfirmationButtons({
    Key? key,
    required this.positiveAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DialogButton.setPositiveButton(
                  action: () => positiveAction(), color: Colors.red)
              .button,
        ),
        Expanded(
          child: DialogButton.setNegativeButton(
                  action: () => Navigator.pop(context),
                  color: Colors.black,
                  text: "No")
              .button,
        ),
      ],
    );
  }
}

class DialogContainer extends StatelessWidget {
  final Widget child;
  final bool withPadding;
  final bool withMargin;
  final EdgeInsetsGeometry? customPadding;
  const DialogContainer(
      {Key? key,
      required this.child,
      this.withPadding = true,
      this.withMargin = true,
      this.customPadding = const EdgeInsets.all(0)})
      : super(key: key);

  static const double _radius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: withMargin ? const EdgeInsets.all(15.0) : null,
            padding: withPadding
                ? customPadding ?? const EdgeInsets.all(26.0)
                : null,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_radius),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class DialogButton {
  late Widget _button;

  // constructs
  DialogButton();
  DialogButton.setNegativeButton({
    String? text,
    Color? color,
    required Function action,
  }) {
    _button = NegativeButton(
      action: action,
      text: text,
      color: color,
    );
  }
  DialogButton.setPositiveButton({
    String? text,
    Color? color,
    required Function action,
  }) {
    _button = PositiveButton(
      action: action,
      text: text,
      color: color,
    );
  }

  // getter
  Widget get button => _button;
  Widget get closeButton => const CloseButton();
}

class NegativeButton extends StatelessWidget {
  final Function action;
  final String? text;
  final Color? color;
  const NegativeButton({Key? key, required this.action, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => action(),
      child: Text(text ?? "No"),
    );
    // return rounded filled button
  }
}

class PositiveButton extends StatelessWidget {
  final Function action;
  final String? text;
  final Color? color;
  const PositiveButton({Key? key, required this.action, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => action(),
      child: Text(text ?? "Yes"),
    );
  }
}
