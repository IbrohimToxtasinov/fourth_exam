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
      studentId: json['studentId'] as String? ?? "",
      studentName: json['studentName'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'imageUrl': imageUrl,
    };
  }
}
