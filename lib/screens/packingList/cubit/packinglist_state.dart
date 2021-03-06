part of 'packinglist_cubit.dart';

@immutable
abstract class PackinglistState {}

class PackinglistInitial extends PackinglistState {}

class PackinglistLoading extends PackinglistState {}

class PackinglistLoaded extends PackinglistState {
  String packListCode;
  String sscc;
  List<String> ssccList;
  PackinglistLoaded({this.packListCode, this.sscc, this.ssccList});
}

class PackinglistError extends PackinglistState {
  final String message;

  PackinglistError({
    this.message,
  });
}
