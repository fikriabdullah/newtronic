import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:keluhanlayanan/bloc/complaintGet/getComplaint_cubit.dart';
import 'package:keluhanlayanan/models/complaint.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'getComplaint_state.dart';

class GetComplaintCubit extends Cubit<GetComplaintState> {
  GetComplaintCubit() : super(GetComplaintInitial());

  void getComplaint()async{
    try{
      List<complaintModel> complaints = <complaintModel>[];
      emit(GetComplaintLoading());
      Response response = await get(Uri.parse('https://6381deed53081dd5498a2113.mockapi.io/complaints'));
      if(response.statusCode == 200){
        List responses = jsonDecode(response.body);
        for(var complaint in responses){
          int tScore = complaint['Nilai'];
          complaints.add(
            complaintModel(
                usia: complaint['Usia'],
                date: complaint['createdAt'],
                name: complaint['name'],
                complaints: complaint['Complaints'],
                pekerjaan: complaint['pekerjaan'],
                score: tScore.toDouble()
            )
          );
        }
        if(complaints.isEmpty){
          emit(GetComplaintEmpty("No Complaints So Far!!"));
        }else{
          emit(GetComplaintLoaded(complaints));
        }

      }else{
        emit(GetComplaintError("Fetching Complaint Failed : ${response.statusCode}"));
      }
    }catch (e){
      emit(GetComplaintError("Fetching Complaint Data Error : ${e.toString()}"));
    }
    
  }

}
