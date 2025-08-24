import 'package:bio_app/features/auth/domain/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({required this.authRepo})
    : super(DeleteAccountInitialState());
  final AuthRepo authRepo;
  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    final result = await authRepo.deleteUser();
    result.fold(
      (failure) {
        emit(DeleteAccountFailureState(message: failure.message));
      },
      (unit) {
        emit(DeleteAccountSuccessState());
      },
    );
  }
}
