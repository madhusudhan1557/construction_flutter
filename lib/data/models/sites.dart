class SiteModel {
  String? sid;
  String? sitename;
  String? sitedesc;
  String? sitelocation;
  String? clientname;
  String? phone;
  String? supervisor;

  SiteModel({
    this.sid,
    this.sitename,
    this.sitedesc,
    this.sitelocation,
    this.clientname,
    this.phone,
    this.supervisor,
  });

  factory SiteModel.fromDocument(Map<String, dynamic> doc) {
    return SiteModel(
      sid: doc['sid'] ?? "",
      sitename: doc['sitename'] ?? "",
      sitedesc: doc['sitedesc'] ?? "",
      sitelocation: doc['sitelocation'] ?? "",
      clientname: doc['clientname'] ?? "",
      phone: doc['phone'] ?? "",
      supervisor: doc['supervisor'] ?? "",
    );
  }
}
