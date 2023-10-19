class MonitoringModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  MonitoringModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  static MonitoringModel fromJson(dynamic map) {
    return MonitoringModel(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      completed: map['completed'],
    );
  }

  static MonitoringModel stub() => MonitoringModel(
        userId: 1,
        id: 1,
        title: 'teste',
        completed: true,
      );
}
