part of 'delete_account_cubit.dart';

sealed class DeleteAccountState extends Equatable {
  final bool isObscure;

  const DeleteAccountState({required this.isObscure});

  @override
  List<Object> get props => [isObscure];
}

final class DeleteAccountInitialState extends DeleteAccountState {
  const DeleteAccountInitialState({super.isObscure = true});
}

final class DeleteAccountLoadingState extends DeleteAccountState {
  const DeleteAccountLoadingState({required super.isObscure});
}

final class DeleteAccountSuccessState extends DeleteAccountState {
  const DeleteAccountSuccessState({required super.isObscure});
}

final class DeleteAccountFailureState extends DeleteAccountState {
  final String message;

  const DeleteAccountFailureState({
    required this.message,
    required super.isObscure,
  });

  @override
  List<Object> get props => [message, isObscure];
}
