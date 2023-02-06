class Gender {
late  int count;
  late String gender;
 late String name;
 late double probability;

  Gender({required this.count, required this.gender, required this.name, required this.probability});

  Gender.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    gender = json['gender'];
    name = json['name'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['gender'] = gender;
    data['name'] = name;
    data['probability'] = probability;
    return data;
  }
}
