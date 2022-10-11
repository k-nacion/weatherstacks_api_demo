import 'package:equatable/equatable.dart';

class Network extends Equatable {
  final bool status;

  const Network({
    required this.status,
  });

  @override
  List<Object> get props => [status];
}
