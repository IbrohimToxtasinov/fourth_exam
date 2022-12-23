class StudentModel {
  final String studentId;
  final String studentName;
  final String imageUrl;

  StudentModel({
    required this.studentId,
    required this.studentName,
    required this.imageUrl,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: json['student_id'] as String? ?? "",
      studentName: json['student_name'] as String? ?? "",
      imageUrl: json['image_url'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'student_name': studentName,
      'image_url': imageUrl,
    };
  }
}
