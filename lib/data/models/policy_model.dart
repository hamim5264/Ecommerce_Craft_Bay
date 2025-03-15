class PolicyModel {
  int? id;
  String? type;
  String? description;

  PolicyModel({this.id, this.type, this.description});

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'],
      type: json['type'],
      description: json['des'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'des': description,
    };
  }
}
