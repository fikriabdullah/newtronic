class complaintModel{
  String date;
  String name;
  String pekerjaan;
  String usia;
  double score;
  List complaints;

  complaintModel({required this.usia, required this.date,
    required this.name, required this.complaints, required this.pekerjaan, required this.score});

  factory complaintModel.fromJson(Map<String, dynamic>json){
    return complaintModel(
        usia: json['Usia'],
        date: json['createdAt'],
        name: json['name'],
        complaints: json['Complaints'],
        pekerjaan: json['pekerjaan'],
        score: json['Nilai']
    );
  }
}
