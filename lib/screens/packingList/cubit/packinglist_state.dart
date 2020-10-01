part of 'packinglist_cubit.dart';

@immutable
abstract class PackinglistState {}

class PackinglistInitial extends PackinglistState {}

class PackinglistLoading extends PackinglistState {}

class PackinglistLoaded extends PackinglistState {
  String packListCode;
  PackinglistLoaded({this.packListCode});
}
