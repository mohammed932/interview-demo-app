part of 'internet_connection_cubit.dart';

abstract class InternetConnectionState extends Equatable {
  final bool hasInternetConnection;
  InternetConnectionState({required this.hasInternetConnection});
}

class InternetConnectionInitial extends InternetConnectionState {
  InternetConnectionInitial({bool? hasInternetConnection})
      : super(hasInternetConnection: true);

  @override
  List<Object> get props => [hasInternetConnection];
}

class InternetConnectionUpdateState extends InternetConnectionState {
  InternetConnectionUpdateState({required bool hasInternetConnection})
      : super(hasInternetConnection: hasInternetConnection);

  @override
  List<Object> get props => [hasInternetConnection];
}
