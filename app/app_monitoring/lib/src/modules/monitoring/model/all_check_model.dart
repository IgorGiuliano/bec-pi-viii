class AllCheckModel {
  int count;

  AllCheckModel({required this.count});

  factory AllCheckModel.fromJson(Map<String, dynamic> json) {
    return AllCheckModel(
      count: json['count'],
    );
  }
}
