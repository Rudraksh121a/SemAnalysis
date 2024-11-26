import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:semanalysis/Controller/take_user_input.dart';

class UserInput1 extends StatelessWidget {
  const UserInput1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    TakeUserInputController takeUserInputController =
        Get.put(TakeUserInputController());
    return Wrap(
      spacing: (screenWidth < 600) ? 20.0 : 30.0,
      runSpacing: (screenWidth < 600) ? 20.0 : 30.0,
      alignment: WrapAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: takeUserInputController.instituteCodeController.value,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Institute Code",
                hintText: "Ex:- 0403",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => (takeUserInputController.instituteCodeError.value != "")
                  ? Text(
                      takeUserInputController.instituteCodeError.value,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: takeUserInputController.branchCodeController.value,
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]*$')),
              ],
              decoration: const InputDecoration(
                labelText: "Branch Code",
                hintText: "Ex:- AL",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => (takeUserInputController.branchCodeError.value != "")
                  ? Text(
                      takeUserInputController.branchCodeError.value,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: takeUserInputController.batchYearController.value,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Batch Year",
                hintText: "Ex:- 22",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => (takeUserInputController.batchYearError.value != "")
                  ? Text(
                      takeUserInputController.batchYearError.value,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }
}
