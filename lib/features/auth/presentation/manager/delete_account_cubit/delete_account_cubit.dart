import '../../../domain/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({required this.authRepo})
    : super(const DeleteAccountInitialState());
  final AuthRepo authRepo;
  Future<void> deleteAccount({String? password}) async {
    emit(DeleteAccountLoadingState(isObscure: state.isObscure));
    final result = await authRepo.deleteAccount(password: password);
    result.fold(
      (failure) {
        emit(
          DeleteAccountFailureState(
            message: failure.message,
            isObscure: state.isObscure,
          ),
        );
      },
      (unit) {
        emit(DeleteAccountSuccessState(isObscure: state.isObscure));
      },
    );
  }

  void togglePasswordVisibility() {
    emit(DeleteAccountInitialState(isObscure: !state.isObscure));
  }
}
