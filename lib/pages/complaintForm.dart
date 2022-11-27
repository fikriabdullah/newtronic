import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keluhanlayanan/bloc/complaintPush/addComplaint_cubit.dart';
class complaintForm extends StatefulWidget {
  const complaintForm({Key? key}) : super(key: key);

  @override
  State<complaintForm> createState() => _complaintFormState();
}

class _complaintFormState extends State<complaintForm> {
  List<String> reasons = <String>[];
  late FocusNode pekerjaanFN;
  late FocusNode usiaFN;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  final formKey = GlobalKey <FormState>();
  final nameCtrl = TextEditingController();
  final pekerjaanCtrl = TextEditingController();
  final usiaCtrl = TextEditingController();
  double finalRate = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pekerjaanFN = FocusNode();
    usiaFN = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pekerjaanFN.dispose();
    usiaFN.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget complainReason(){
      if(finalRate > 2){
        return Container();
      }else if(finalRate <= 2 && finalRate >0){
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CheckboxListTile(
                  activeColor: Colors.blue,
                  title: Text("Pelayanan Tidak Ramah"),
                  value: value2,
                  onChanged: (value){
                    setState(() {
                      value2 = value!;
                      if(value == true){
                        reasons.add("Pelayanan Tidak Ramah");
                      }else if(value == false){
                        reasons.remove("Pelayanan Tidak Ramah");
                      }
                    });
                    print(reasons);
                  }
              ),
              CheckboxListTile(
                  activeColor: Colors.blue,
                  title: Text("Kebersihan Kurang"),
                  value: value3,
                  onChanged: (value){
                    setState(() {
                      value3 = value!;
                      if(value == true){
                        reasons.add("Kebersihan Kurang");
                      }else if(value == false){
                        reasons.remove("Kebersihan Kurang");
                      }
                    });
                    print(reasons);
                  }
              ),
              CheckboxListTile(
                  activeColor: Colors.blue,
                  title: Text("Antrian Lama"),
                  value: value4,
                  onChanged: (value){
                    setState(() {
                      value4 = value!;
                      if(value == true){
                        reasons.add("Antrian Lama");
                      }else if(value == false){
                        reasons.remove("Antrian Lama");
                      }
                    });
                    print(reasons);
                  }
              )
            ],
          ),
        );
      }
      return Container();
    }

    Widget loadingDialog(){
      return Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              strokeWidth: 10,
            ),
          )
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text("Keluhan Layanan")),
      ),
      body: Stack(
        children: [
          Form(
              key: formKey,
              child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: nameCtrl,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value)=> value == null || value.isEmpty ? "Silahkan Isi Nama Anda Anda" : null,
                      decoration: InputDecoration(
                        label: Text("Nama"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                ),Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: usiaCtrl,
                    focusNode: usiaFN,
                    autofocus: true,
                    validator: (value)=> value == null || value.isEmpty ? "Silahkan Isi Usia Anda" : null,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        label: Text("Usia"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: pekerjaanCtrl,
                    focusNode: pekerjaanFN,
                    validator: (value)=> value == null || value.isEmpty ? "Silahkan Isi Pekerjaan/Profesi Anda" : null,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        label: Text("Pekerjaan"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Text("Nilai Pelayanan Kami : "),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      itemPadding: EdgeInsets.symmetric(horizontal: 5),
                      updateOnDrag: true,
                      itemBuilder: (context, _ ){
                        return Icon(Icons.star, color: Colors.yellow,);
                      },
                      onRatingUpdate: (rating){
                        setState(() {
                          finalRate = rating;
                        });
                      }
                  ),
                ),
                complainReason(),
                ElevatedButton(
                    onPressed: (){
                      String crTime = DateTime.now().toString();
                      if(formKey.currentState!.validate()){
                        if(finalRate != 0){
                          if(finalRate <= 2 && reasons.isNotEmpty){
                            context.read<AddComplaintCubit>()
                                .submitComplain(usiaCtrl.text, crTime, nameCtrl.text, reasons, pekerjaanCtrl.text, finalRate);
                          }else if(finalRate <= 2 && reasons.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Silahkan Isi Alasan Komplain")));
                          }else if(finalRate > 2 ){
                            context.read<AddComplaintCubit>()
                                .submitComplain(usiaCtrl.text, crTime, nameCtrl.text, reasons, pekerjaanCtrl.text, finalRate);
                          }
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Silahkan Isi Nilai Layanan Kami")));
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.lightBlue[600])
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Submit Complain"),
                    )
                ),
                GestureDetector(
                  onDoubleTap: (){
                    Navigator.pushNamed(context, '/dashboardComplaint');
                  },
                  child: ElevatedButton(
                      onPressed: (){},
                      child: Text("Lihat Keluhan")),
                )
              ],
              )
            ),
          BlocConsumer<AddComplaintCubit, AddComplaintState>(
              builder: (context, state){
                if(state is AddComplaintLoading){
                  print("Push Loading $state");
                  return loadingDialog();
                }
                return Container();
              },
              listener: (context, state){
                if(state is AddComplaintCompleted){
                  print("Push Completed $state" );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Untuk Melihat Daftar Keluhan, Klik 2X Button 'Lihat Keluhan'")));
                }else if(state is AddComplaintError){
                  print("${state.errorMessage}");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add Complaint Error : ${state.errorMessage}")));
                }
              }
          )
          ],
        ),
      );
    }
}
