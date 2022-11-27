import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:keluhanlayanan/bloc/complaintPush/addComplaint_cubit.dart';
import 'package:keluhanlayanan/models/complaint.dart';
import 'package:meta/meta.dart';

part 'addComplaint_state.dart';

class AddComplaintCubit extends Cubit<AddComplaintState> {
  AddComplaintCubit() : super(AddComplaintInitial());
  
  void submitComplain(String usia, String date, String name, List complaints, String pekerjaan, double score)async{
    try{
      emit(AddComplaintLoading());
      Response response = await post(Uri.parse('https://6381deed53081dd5498a2113.mockapi.io/complaints'),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(
            {
              "createdAt" : date,
              "name" : name,
              "pekerjaan" : pekerjaan,
              "Usia" : usia,
              "Nilai" : score,
              "Complaints" : complaints
            }
        )
      );
      if(response.statusCode == 201){
        emit(AddComplaintCompleted());
      }else{
        emit(AddComplaintError("Submit Complaint Error : ${response.statusCode}}"));
      }

    }catch (e){
      emit(AddComplaintError("Submit Complaint Error : ${e.toString()}"));
    }
  }
}
