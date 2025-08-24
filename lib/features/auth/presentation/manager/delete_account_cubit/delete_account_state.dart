part of 'delete_account_cubit.dart';

sealed class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

final class DeleteAccountInitialState extends DeleteAccountState {}

final class DeleteAccountLoadingState extends DeleteAccountState {}

final class DeleteAccountSuccessState extends DeleteAccountState {}

final class DeleteAccountFailureState extends DeleteAccountState {
  final String message;

  const DeleteAccountFailureState({required this.message});
}
