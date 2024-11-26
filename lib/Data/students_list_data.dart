import 'package:get/get.dart';

class StudentsListData extends GetxController {
  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;

  void updateUsers(List<Map<String, dynamic>> value) {
    users.value = value;
  }

  List<String>? columnHeaders;
  List<String> getColumnHeader() {
    columnHeaders = users.isNotEmpty ? users.first.keys.toList() : [];
    return columnHeaders!;
  }

  List<String> getSubjects() {
    List<String> subjects = (columnHeaders == null)
        ? []
        : columnHeaders!
            .where((header) => ![
                  "S.No.",
                  "Name",
                  "Enrollment Number",
                  "SGPA",
                  "CGPA",
                  "Result"
                ].contains(header))
            .toList();
    return subjects;
  }
}
