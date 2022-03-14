class OrganizationInfo {
  String? name;
  String? imageUrl;
  String? oid;

  OrganizationInfo({this.name, this.imageUrl, this.oid});

  OrganizationInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    oid = json['oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['oid'] = oid;
    return data;
  }
}
