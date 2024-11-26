import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:semanalysis/Data/students_list_data.dart';

class DataFetchController extends GetxController {
  RxDouble percentDownload = 0.0.obs;
  RxBool isFetching = false.obs;
  StudentsListData studentsListData = Get.put(StudentsListData());
  RxString fetchDataError = "".obs;
  int tryCount = 0;
  int resultNotFoundCount = 0;

  RxList<Map<String, dynamic>> completeFetchedData =
      <Map<String, dynamic>>[].obs;
  Map<String, dynamic> singleMapedStudent = {};

  final Dio dio = Dio(); // Create a Dio instance

  void getCorrectData(List<Map<String, dynamic>> singleStudent) {
    int serialNumber = completeFetchedData.length + 1;
    singleMapedStudent["S.No."] = serialNumber.toString();

    // Merge the relevant parts of the student data
    singleMapedStudent.addAll(singleStudent[0]); // Enrollment and name data
    singleMapedStudent.addAll(singleStudent[1]); // Subject-wise marks
    singleMapedStudent['CGPA'] = singleStudent[2]['CGPA']; // CGPA
    singleMapedStudent['SGPA'] = singleStudent[2]['SGPA']; // SGPA
    singleMapedStudent['Result'] = singleStudent[2]['Result']; // Result
  }

  Future<void> fetchResults(
      String fullRoll, String startRoll, String endRoll, String sem) async {
    isFetching.value = true;
    try {
      int? start = int.tryParse(startRoll);
      int? end = int.tryParse(endRoll);
      int total = (end! - start! + 1);

      for (int i = start; i <= end; i++) {
        // Fetch data from the server using Dio
        final response = await dio.get(
          'http://127.0.0.1:5000/get_input',
          // 'http://192.168.51.58:5000/get_input',
          queryParameters: {
            'enrollment': '$fullRoll$i',
            'sem': sem,
          },
        );

        if (response.statusCode == 200) {
          // Sanitize the response data before processing
          dynamic sanitizedResponse = sanitizeData(response.data);
          if (sanitizedResponse == "try again") {
            if (tryCount > 1) {
              isFetching.value = false;
              fetchDataError.value = "Please Check Your Internet Connection";
              clearOnError();
              break;
            }
            i--;
            tryCount++;
            continue;
          } else if (sanitizedResponse == "Result not found") {
            if (resultNotFoundCount < 2) {
              i--;
              resultNotFoundCount++;
              continue;
            } else if (resultNotFoundCount == 2 && i == start) {
              isFetching.value = false;
              fetchDataError.value = "Result Not Found";
              clearOnError();
              break;
            } else {
              Map<String, dynamic> studentData = Map.from(completeFetchedData.first);

              studentData["S.No."] =
                  (completeFetchedData.length + 1).toString();
              studentData["Enrollment Number"] = "null";
              studentData["Name"] = "null";
              // Set all keys except specified ones to 'null'
              studentData.forEach((key, value) {
                if (key != "S.No." &&
                    key != "Enrollment Number" &&
                    key != "Name" &&
                    key != "CGPA" &&
                    key != "SGPA" &&
                    key != "Result") {
                  studentData[key] = "null"; // Set to 'null' for other keys
                }
              });

              studentData['CGPA'] = "null";
              studentData['SGPA'] = "null";
              studentData['Result'] = "null";

              completeFetchedData.add(Map<String, dynamic>.from(studentData));
              tryCount = 0;
              resultNotFoundCount = 0;
              percentDownload.value = (i - start + 1) / total;
            }
          } else {
            List<Map<String, dynamic>> singleStudent =
                List<Map<String, dynamic>>.from(sanitizedResponse);

            // Store the fetched data in singleStudent
            getCorrectData(singleStudent);

            // Add the merged data to the completeFetchedData list
            completeFetchedData
                .add(Map<String, dynamic>.from(singleMapedStudent));
            tryCount = 0;
            resultNotFoundCount = 0;
            percentDownload.value = (i - start + 1) / total;
          }
        } else {
          fetchDataError.value = "Server is Offline or Other Server Issue";
        }
      }

      // Update the progress to 100%
      percentDownload.value = 1.0;
      await Future.delayed(const Duration(seconds: 2));
      isFetching.value = false;
      studentsListData.users.addAll(completeFetchedData);
    } catch (e) {
      fetchDataError.value = "Unable to Fetch Data from the Server";
    } finally {
      isFetching.value = false;
      clearOnError();
    }
  }

  void clearOnError() {
    completeFetchedData.clear();
    tryCount = 0;
    resultNotFoundCount = 0;
    percentDownload.value = 0.0;
  }

  // Sanitize data to replace NaN or null values
  dynamic sanitizeData(dynamic data) {
    if (data is Map) {
      data.forEach((key, value) {
        if (value == 'NaN' || value == null) {
          data[key] = 0;
        }
      });
    } else if (data is List) {
      for (int i = 0; i < data.length; i++) {
        if (data[i] == 'NaN' || data[i] == null) {
          data[i] = 0;
        } else if (data[i] is Map) {
          sanitizeData(data[i]); // Recursively sanitize if the element is a Map
        }
      }
    }
    return data;
  }
}
