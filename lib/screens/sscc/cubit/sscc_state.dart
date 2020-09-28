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
  SsccLoaded(
      {this.ssccValue,
      this.eanValue,
      this.dmValue,
      this.eanVisibility,
      this.dmVisibility});
}
