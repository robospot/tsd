part of 'sscc_cubit.dart';

@immutable
abstract class SsccState {}

class SsccInitial extends SsccState {}

class SsccLoading extends SsccState {}

class SsccLoaded extends SsccState {
  String ssccValue;
  String eanValue;
  String dmValue;
  bool eanVisibility;
  bool dmVisibility;
  int ssccCount;
  int eanCount;
  SsccLoaded(
      {this.ssccValue,
      this.eanValue,
      this.dmValue,
      this.eanVisibility,
      this.dmVisibility,
      this.ssccCount,
      this.eanCount});
}

class SsccError extends SsccState {
 final String message;

  SsccError({
    this.message,
  });
}
