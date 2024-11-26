import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TakeUserInputController extends GetxController {
  RxString instituteCodeError = "".obs;
  RxString branchCodeError = "".obs;
  RxString batchYearError = "".obs;
  RxString rollStartError = "".obs;
  RxString rollEndError = "".obs;
  RxString selectedSemesterError = "".obs;

  RxBool validInstituteCode = false.obs;
  RxBool validBranchCode = false.obs;
  RxBool validBatchYear = false.obs;
  RxBool validRollStart = false.obs;
  RxBool validRollEnd = false.obs;
  RxBool validRollStartEnd = false.obs;

  List<String> semester = <String>['1', '2', '3', '4', '5', '6', '7', '8'];
  var instituteCodeController = TextEditingController().obs;
  var branchCodeController = TextEditingController().obs;
  var batchYearController = TextEditingController().obs;
  var rollStartController = TextEditingController().obs;
  var rollEndController = TextEditingController().obs;
  RxString selectedSemester = "".obs;

  void updateSemester(String value) {
    selectedSemester.value = value;
  }

  void checkUserInput() {
    clearError();
    validInstituteCode.value =
        checkInstituteCode(instituteCodeController.value.text);
    validBranchCode.value = checkBranchCode(branchCodeController.value.text);
    validBatchYear.value = checkBatchYear(batchYearController.value.text);
    validRollStart.value = checkRollStart(rollStartController.value.text);
    validRollEnd.value = checkRollEnd(rollEndController.value.text);
    validRollStartEnd.value = (validRollStart.value && validRollEnd.value)
        ? checkRollNoStartEnd(
            rollStartController.value.text, rollEndController.value.text)
        : false;
    checkSemester(selectedSemester.value);
  }

  // for making real enrollment no. concat all string
  String getFullRollNo() {
    if (validInstituteCode.value &&
        validBranchCode.value &&
        validBatchYear.value &&
        validRollStartEnd.value) {
      StringBuffer stringBuffer = StringBuffer();
      stringBuffer.writeAll([
        instituteCodeController.value.text,
        branchCodeController.value.text,
        batchYearController.value.text,
      ]);
      return stringBuffer.toString();
    } else {
      return "";
    }
  }

  // for getting start roll no
  String getStartRollNo() {
    return rollStartController.value.text;
  }

  // for getting end roll no
  String getEndRollNo() {
    return rollEndController.value.text;
  }

  // for getting semester value
  String getSemester() {
    return selectedSemester.toString();
  }

  // for clear all error fields
  void clearError() {
    instituteCodeError.value = "";
    branchCodeError.value = "";
    batchYearError.value = "";
    rollStartError.value = "";
    rollEndError.value = "";
    selectedSemesterError.value = "";
  }

  // for check roll no start and roll no end, completly
  bool checkRollNoStartEnd(String value1, String value2) {
    if (value1[0] != value2[0]) {
      rollStartError.value = "First Digit must be Same.";
      rollEndError.value = "First Digit must be Same.";
      return false;
    } else {
      int? rollS = int.tryParse(value1);
      int? rollE = int.tryParse(value2);
      if (rollS == 0000) {
        rollStartError.value = "Roll No. don't starts with \"0000\"";
        return false;
      }
      if (rollE == 0000) {
        rollEndError.value = "Roll No. don't ends with \"0000\"";
        return false;
      }
      // else if ((rollE! - (rollS! - 1)) > 10) {
      //   rollEndError.value = "Student Limit 10";
      //   return false;
      // }
      else if ((rollE! - rollS!) < 0) {
        rollStartError.value = "Please Enter in Increasing Order.";
        return false;
      } else if (rollS == rollE) {
        rollStartError.value = "Don't enter Same Roll No.";
        rollEndError.value = "Don't enter Same Roll No.";
        return false;
      }
      return true;
    }
  }

  // for check institute code
  bool checkInstituteCode(String value) {
    if (value.isEmpty || value == "") {
      instituteCodeError.value = "Please Enter Institute Code.";
      return false;
    } else if (value.length != 4) {
      instituteCodeError.value = "Institute Code must be 4 digit.";
      return false;
    } else if (value == "0000") {
      instituteCodeError.value = "Institute Code can't be \"0000\"";
      return false;
    } else {
      return true;
    }
  }

  // for check branch code
  bool checkBranchCode(String value) {
    if (value.isEmpty || value == "") {
      branchCodeError.value = "Please Enter Branch Code.";
      return false;
    } else if (value.length != 2) {
      branchCodeError.value = "Branch Code must be 2 character.";
      return false;
    } else {
      return true;
    }
  }

  // for check batch year
  bool checkBatchYear(String value) {
    if (value.isEmpty || value == "") {
      batchYearError.value = "Please Enter Batch Year.";
      return false;
    } else if (value.length != 2) {
      batchYearError.value = "Batch Year must be 2 digit.";
      return false;
    } else if (value == "00") {
      batchYearError.value = "Batch Year can't be \"00\"";
      return false;
    } else {
      return true;
    }
  }

  // for check starting roll no
  bool checkRollStart(String value) {
    if (value.isEmpty || value == "") {
      rollStartError.value = "Please Enter Roll No. (Start)";
      return false;
    } else if (value.length != 4) {
      rollStartError.value = "Roll No. must be 4 digit.";
      return false;
    } else {
      return true;
    }
  }

  // for check ending roll no
  bool checkRollEnd(String value) {
    if (value.isEmpty || value == "") {
      rollEndError.value = "Please Enter Roll No. (End)";
      return false;
    } else if (value.length != 4) {
      rollEndError.value = "Roll No. must be 4 digit.";
      return false;
    } else {
      return true;
    }
  }

  // for check semester
  void checkSemester(String value) {
    if (value.isEmpty || value == "") {
      selectedSemesterError.value = "Please Select Semester.";
    }
  }

  void clearFields() {
    instituteCodeController.value.clear();
    branchCodeController.value.clear();
    batchYearController.value.clear();
    rollStartController.value.clear();
    rollEndController.value.clear();
    selectedSemester.value = "";
  }
}
