import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController get usernameController => _usernameController;
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get noHpController => _noHpController;
  GlobalKey<FormState> get formKey => _formKey;
}
