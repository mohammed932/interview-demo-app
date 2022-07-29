import 'package:base_flutter/shared/models/error_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'generic_state.dart';

class GenericCubit<T> extends Cubit<GenericCubitState<T>> {
  GenericCubit(T data) : super(GenericInitialState<T>(data));

  onUpdateData(T data) {
    emit(GenericUpdatedState<T>(data, !state.changed));
  }

  onUpdateToInitState(T data) {
    emit(GenericInitialState<T>(data));
  }

  onLoadingState() {
    emit(GenericLoadingState<T>(data: state.data, changed: !state.changed));
  }

  onErrorState(ErrorResponse responseError) {
    emit(GenericErrorState<T>(responseError: responseError, changed: !state.changed, data: state.data));
  }
}
