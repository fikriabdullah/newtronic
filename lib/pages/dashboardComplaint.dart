import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keluhanlayanan/bloc/complaintGet/getComplaint_cubit.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
class dashboardComplaint extends StatefulWidget {
  const dashboardComplaint({Key? key}) : super(key: key);

  @override
  State<dashboardComplaint> createState() => _dashboardComplaintState();
}

class _dashboardComplaintState extends State<dashboardComplaint> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetComplaintCubit>().getComplaint();
  }
  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: Text("Daftar Keluhan"),
      ),
        body: BlocConsumer<GetComplaintCubit, GetComplaintState>(
            builder: (context, state){
              if(state is GetComplaintLoading){
                return loadingDialog();
              }else if(state is GetComplaintEmpty){
                return Center(
                  child: Text("${state.emptyMessage}"),
                );
              }else if(state is GetComplaintLoaded){
                return ExpandedTileList.builder(
                    itemCount: state.complaint.length,
                    itemBuilder: (context, index, controller){

                      Widget jenisKomplain(){
                        if(state.complaint[index].complaints.isEmpty){
                          return Text("No Complaints");
                        }else{
                          return SizedBox(
                            width: 500,
                            height: 100,
                            child: ListView.builder(
                              itemCount: state.complaint[index].complaints.length,
                                itemBuilder: (context, idx){
                                  return Card(
                                    child: Row(
                                      children: [
                                        Text("${state.complaint[index].complaints[idx]}", style: TextStyle(fontSize: 20))
                                      ],
                                    ),
                                  );
                                }
                            ),
                          );
                        }
                      }

                      DateTime dateTime = DateTime.parse(state.complaint[index].date);
                      String date = DateFormat.yMMMMEEEEd().format(dateTime);
                      String Time = DateFormat.Hms().format(dateTime);
                      return ExpandedTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${state.complaint[index].name}",style: TextStyle(
                                fontSize: 30
                              ),),
                              RatingBar.builder(
                                itemSize: 30,
                                ignoreGestures: true,
                                  initialRating: state.complaint[index].score,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 5),
                                  updateOnDrag: true,
                                  itemBuilder: (context, _ ){
                                    return Icon(Icons.star, color: Colors.yellow,);
                                  }, onRatingUpdate: (double value) {},
                              ),
                            ],
                          ),
                          content: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Text("Created On : ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                      Text("$date : $Time", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text("Name : ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      Text("${state.complaint[index].name}", style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text("Usia : ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      Text("${state.complaint[index].usia}", style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text("Pekerjaan : ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      Text("${state.complaint[index].pekerjaan}", style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                ),
                                Text("Jenis Komplain : ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                jenisKomplain()
                              ],
                            ),
                          ),
                          controller: index == 2 ? controller.copyWith(isExpanded: true) : controller,
                          onTap: (){
                            debugPrint("tapped");
                          },
                        onLongTap: (){
                            debugPrint("Loooonggg Tap");
                        },
                      );
                    }
                );
              }else if(state is GetComplaintError){
                return Center(child: Text("${state.errorMessage}"));
              }
              return Container();
            },
            listener: (context, state){
              if(state is GetComplaintLoading){
                print("Fetching Complaint : $state");
              }else if(state is GetComplaintLoaded){
                print("Fetching Complaint : ${state.complaint.length} ");
              }else if(state is GetComplaintError){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.errorMessage}")));
                print("Fetching Failed : $state : ${state.errorMessage}");
              }
            }
        )
    );
  }
}
