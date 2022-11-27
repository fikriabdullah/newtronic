part of 'addComplaint_cubit.dart';

@immutable
abstract class AddComplaintState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddComplaintInitial extends AddComplaintState {

}

class AddComplaintLoading extends AddComplaintState{

}

class AddComplaintCompleted extends AddComplaintState{

}

class AddComplaintError extends AddComplaintState{
  String errorMessage;
  AddComplaintError(this.errorMessage);
}
