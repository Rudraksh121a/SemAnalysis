import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:semanalysis/Controller/take_user_input.dart';

class UserInput2 extends StatelessWidget {
  const UserInput2({super.key});

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
              controller: takeUserInputController.rollStartController.value,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Roll No. Start",
                hintText: "Ex:- 1001",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => (takeUserInputController.rollStartError.value != "")
                  ? Text(
                      takeUserInputController.rollStartError.value,
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
              controller: takeUserInputController.rollEndController.value,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Roll No. End",
                hintText: "Ex:- 1125",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => (takeUserInputController.rollEndError.value != "")
                  ? Text(
                      takeUserInputController.rollEndError.value,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        Obx(
          () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 50,
                    maxWidth: 130,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    hint: Text("Semester",
                        style: Theme.of(context).textTheme.labelLarge),
                    value:
                        takeUserInputController.selectedSemester.value.isEmpty
                            ? null
                            : takeUserInputController.selectedSemester.value,
                    onChanged: (newValue) {
                      takeUserInputController
                          .updateSemester(newValue.toString());
                    },
                    underline: const SizedBox.shrink(),
                    alignment: AlignmentDirectional.centerStart,
                    dropdownColor: Theme.of(context).colorScheme.onPrimary,
                    style: Theme.of(context).textTheme.labelMedium,
                    isExpanded: true,
                    menuWidth: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    items: takeUserInputController.semester
                        .map<DropdownMenuItem>((String value) {
                      return DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: value,
                          child: Text(value));
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                (takeUserInputController.selectedSemester.value == "")
                    ? Text(
                        takeUserInputController.selectedSemesterError.value,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ],
    );
  }
}
