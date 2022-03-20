class CovidIdentification {
  late String identificationMethod;
  late String identificationData;

  CovidIdentification(
      {required this.identificationMethod, required this.identificationData});

  CovidIdentification.fromJson(Map<String, dynamic> json) {
    identificationMethod = json['identificationMethod'];
    identificationData = json['identificationData'];
  }

  CovidIdentification.fromFormData(
      {required String method, required String data}) {
    identificationMethod = method;
    identificationData = data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identificationMethod'] = identificationMethod;
    data['identificationData'] = identificationData;
    return data;
  }
}
