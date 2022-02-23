class OrganizationInfo {
  late String id;
  late String name;
  late String endpoint;
  late String apiKey;

  OrganizationInfo(
      {required this.id,
      required this.name,
      required this.endpoint,
      required this.apiKey});

  OrganizationInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    endpoint = json['endpoint'];
    apiKey = json['apiKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['endpoint'] = this.endpoint;
    data['apiKey'] = this.apiKey;
    return data;
  }
}
