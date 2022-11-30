class WorksModel {
  String? wid;
  final String title;
  final DateTime startdate;
  final DateTime endDate;
  String? workdesc;
  double? progress;

  WorksModel({
    this.wid,
    required this.title,
    required this.startdate,
    required this.endDate,
    this.workdesc,
    this.progress,
  });

  factory WorksModel.fromDocument(Map<String, dynamic> doc) {
    return WorksModel(
      title: doc["title"] ?? "",
      startdate: doc["startdate"] ?? "",
      endDate: doc['endDate'] ?? "",
      workdesc: doc['workdesc'] ?? "",
      progress: doc['progress'] ?? "",
    );
  }
}
