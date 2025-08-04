part of 'unit_cubit.dart';

@immutable
sealed class UnitState {}

final class UnitInitialState extends UnitState {}

final class UnitLoadingState extends UnitState {}

final class UnitLoadedState extends UnitState {
  final List<UnitEntity> units;
  UnitLoadedState({required this.units});
}

final class UnitErrorState extends UnitState {
  final String message;
  UnitErrorState({required this.message});
}
