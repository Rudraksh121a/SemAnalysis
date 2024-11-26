import 'package:excel/excel.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:get/get.dart';

RxBool isDownloading = false.obs;
RxString downloadExcelError = "".obs;

Future<void> downloadDynamicExcel(
    List<Map<String, dynamic>> students, List<String> headers) async {
  isDownloading.value = true;
  // Check if there are headers or students
  if (headers.isEmpty || students.isEmpty) {
    downloadExcelError.value =
        "No data to download."; // Log a message or handle as needed
    return; // Exit early if there's no data
  }
  try {
    // Create a new Excel document
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];
    List<TextCellValue> headerCells =
        headers.map((header) => TextCellValue(header)).toList();
    sheet.appendRow(headerCells);

    // Append student data rows
    for (var student in students) {
      List<TextCellValue> row = headers.map((header) {
        var value = student[header];
        return TextCellValue(value?.toString() ?? ''); // Handle null values
      }).toList();
      sheet.appendRow(row); // Add rows to sheet
    }

    // Encode the Excel file to binary format
    var bytes = excel.encode();

    // Save the file using the helper method for downloading
    SavingHelper.saveFile(bytes, "SEManalysis.xlsx");
  } catch (e) {
    downloadExcelError.value = "Error in downloading Excel.";
  } finally {
    isDownloading.value = false;
  }
}

class SavingHelper {
  static List<int>? saveFile(List<int>? val, String fileName) {
    if (val == null) return null;

    // Create a Blob from the binary data
    final blob = html.Blob([val]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an anchor element for downloading
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = fileName; // Set the downloaded file name
    html.document.body?.children.add(anchor);

    // Trigger the download by programmatically clicking the anchor
    anchor.click();

    // Clean up by removing the anchor and revoking the object URL
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    return val;
  }
}
