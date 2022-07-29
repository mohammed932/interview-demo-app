part of 'generic_cubit.dart';

abstract class GenericCubitState<T> extends Equatable {
  final T data;
  final bool changed;
  final ErrorResponse? responseError;
  const GenericCubitState({required this.data, required this.changed, this.responseError});
}

class GenericInitialState<T> extends GenericCubitState<T> {
  GenericInitialState(T data) : super(data: data, changed: false, responseError: null);

  @override
  List<Object> get props => [changed];
}

class GenericLoadingState<T> extends GenericCubitState<T> {
  GenericLoadingState({required T data, required bool changed}) : super(data: data, changed: changed);

  @override
  List<Object> get props => [changed];
}

class GenericUpdatedState<T> extends GenericCubitState<T> {
  GenericUpdatedState(T data, bool changed) : super(data: data, changed: changed, responseError: null);

  @override
  List<Object> get props => [changed];
}

class GenericErrorState<T> extends GenericCubitState<T> {
  GenericErrorState({required T data, required ErrorResponse responseError, required bool changed})
      : super(data: data, changed: changed, responseError: responseError);
  @override
  List<Object> get props => [changed];
}
