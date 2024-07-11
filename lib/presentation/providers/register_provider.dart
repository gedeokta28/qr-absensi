import 'package:dio/dio.dart';
import 'package:qr_absensi/domain/usecases/do_register.dart';
import 'package:qr_absensi/presentation/providers/form_provider.dart';
import 'package:qr_absensi/presentation/state/register_state.dart';
import 'package:qr_absensi/utility/failures.dart';
import 'package:qr_absensi/utility/helper.dart';
import 'package:qr_absensi/utility/injection.dart';
import 'package:qr_absensi/utility/session_helper.dart';

class RegisterProvider extends FormProvider {
  final DoRegister doRegister;
  final session = locator<Session>();

  RegisterProvider({required this.doRegister});

  Stream<RegisterState> doRegisterApi() async* {
    showLoading();
    yield RegisterLoading();
    FormData formData = FormData.fromMap({
      'username': usernameController.text,
      'nama_lengkap': fullNameController.text,
      'password': passwordController.text
    });

    final loginResult = await doRegister.call(formData);
    yield* loginResult.fold((failure) async* {
      dismissLoading();
      yield RegisterFailure(failure: ServerFailure(message: failure.message));
    }, (result) async* {
      if (result.status == 'failed') {
        dismissLoading();
        yield RegisterFailure(failure: const ServerFailure());
      } else {
        dismissLoading();
        yield RegisterSuccess(data: result);
      }
    });
  }
}
