import 'package:fifth_exam/data/models/students/students_model.dart';
import 'package:fifth_exam/data/services/uploader_service/file_uploader.dart';
import 'package:fifth_exam/view_models/students_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateStudentsScreen extends StatefulWidget {
  const UpdateStudentsScreen({Key? key, required this.studentModel})
      : super(key: key);

  final StudentModel studentModel;

  @override
  State<UpdateStudentsScreen> createState() => _UpdateStudentsScreenState();
}

class _UpdateStudentsScreenState extends State<UpdateStudentsScreen> {
  final TextEditingController nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String imageUrl = "";

  @override
  void initState() {
    nameController.text = widget.studentModel.studentName;
    imageUrl = widget.studentModel.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Student"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  maxLength: 15,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: "Name",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showPicker(context);
                  },
                  child: const Text(
                    "Upload Student Image",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    StudentModel studentModel = StudentModel(
                      studentId: widget.studentModel.studentId,
                      studentName: nameController.text,
                      imageUrl: imageUrl,
                    );

                    Provider.of<StudentsViewModel>(context, listen: false)
                        .updateStudent(studentModel);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Update Student",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = (await FileUploader.imageUploader(pickedFile));
      setState(() {});
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = (await FileUploader.imageUploader(pickedFile));
      setState(() {});
    }
  }
}
