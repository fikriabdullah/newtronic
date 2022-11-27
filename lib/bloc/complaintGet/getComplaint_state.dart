part of 'getComplaint_cubit.dart';

@immutable
abstract class GetComplaintState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetComplaintInitial extends GetComplaintState {

}

class GetComplaintLoading extends GetComplaintState{
}

class GetComplaintLoaded extends GetComplaintState{
  final List<complaintModel> complaint;
  GetComplaintLoaded(this.complaint);
}

class GetComplaintError extends GetComplaintState{
  final String? errorMessage;
  GetComplaintError(this.errorMessage);
}

class GetComplaintEmpty extends GetComplaintState{
  final String? emptyMessage;
  GetComplaintEmpty(this.emptyMessage);
}