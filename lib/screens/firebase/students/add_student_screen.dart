import 'package:fifth_exam/data/models/students/students_model.dart';
import 'package:fifth_exam/data/services/uploader_service/file_uploader.dart';
import 'package:fifth_exam/utils/my_utils.dart';
import 'package:fifth_exam/view_models/students_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddStudentsScreen extends StatefulWidget {
  const AddStudentsScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentsScreen> createState() => _AddStudentsScreenState();
}

class _AddStudentsScreenState extends State<AddStudentsScreen> {
  final TextEditingController nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                maxLength: 20,
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
                width: imageUrl.isEmpty ? 0 : 200,
                height: imageUrl.isEmpty ? 0 : 200,
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
                  if (nameController.text.isNotEmpty) {
                    if (imageUrl.isNotEmpty) {
                      StudentModel studentModel = StudentModel(
                        studentName: nameController.text,
                        studentId: "",
                        imageUrl: imageUrl,
                      );

                      Provider.of<StudentsViewModel>(context, listen: false)
                          .addStudent(studentModel);
                    } else {
                      MyUtils.getMyToast(message: "Rasm kiriting !!!");
                      return;
                    }
                  } else {
                    MyUtils.getMyToast(message: "Ism kiriting !!!");
                    return;
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  "Add Student",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
