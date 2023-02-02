abstract class BNBStates {}
class InitialState extends BNBStates{}
class ChangeBNBState extends BNBStates{}
class ChangeLightState extends BNBStates{}
class ChangeDarkState extends BNBStates{}
class LoadingStates extends BNBStates{}
class GetBusinessSuccess extends BNBStates{}
class GetSportsSuccess extends BNBStates{}
class GetScienceSuccess extends BNBStates{}
class GetSearchSuccess extends BNBStates{}
class GetSearchError extends BNBStates{
  final String error ;
  GetSearchError(this.error);
}
class GetBusinessError extends BNBStates{
  final String error ;
  GetBusinessError(this.error);
}
class GetSportsError extends BNBStates{
  final String error ;
  GetSportsError(this.error);
}
class GetScienceError extends BNBStates{
  final String error ;
  GetScienceError(this.error);
}
