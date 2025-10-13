import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PLoadEvent extends ProductEvent {
  PLoadEvent();
}
