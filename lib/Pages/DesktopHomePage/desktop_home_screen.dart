import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:semanalysis/Config/image_icon.dart';
import 'package:semanalysis/Controller/data_fetch_controller.dart';
import 'package:semanalysis/Controller/take_user_input.dart';
import 'package:semanalysis/Data/excel_download.dart';
import 'package:semanalysis/Data/students_list_data.dart';
import 'package:semanalysis/Pages/DesktopHomePage/Widgets/charts_visual.dart';
import 'package:semanalysis/Pages/DesktopHomePage/Widgets/student_list_table.dart';
import 'package:semanalysis/Pages/DesktopHomePage/Widgets/user_input_1.dart';
import 'package:semanalysis/Pages/DesktopHomePage/Widgets/user_input_2.dart';
import 'package:semanalysis/Widgets/about_dialog.dart';
import 'package:semanalysis/Widgets/primary_button.dart';

class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentsListData studentsListData = Get.put(StudentsListData());
    DataFetchController dataFetchController = Get.put(DataFetchController());
    TakeUserInputController takeUserInputController =
        Get.put(TakeUserInputController());
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AssetsImage.appLogoSVG,
          ),
        ),
        title: SizedBox(
          width: (screenWidth < 600) ? 130 : 170,
          child: SvgPicture.asset(
            AssetsImage.mainAppLogo,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surface,
              BlendMode.srcIn,
            ),
          ),
        ),
        elevation: (screenWidth < 600) ? 5 : 10,
        shadowColor: Theme.of(context).colorScheme.onSecondary,
        titleSpacing: (screenWidth < 600) ? 10 : 20,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              aboutDialog(context);
            },
            icon: Icon(
              Icons.info_rounded,
              applyTextScaling: true,
              size: (screenWidth < 600) ? 24 : 30,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all((screenWidth < 600) ? 16.0 : 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: (screenWidth < 600)
                      ? const EdgeInsets.only(top: 14, bottom: 30)
                      : const EdgeInsets.only(top: 30, bottom: 50),
                  child: Text(
                    "RGPV B.Tech Result Only",
                    style: (screenWidth < 600)
                        ? Theme.of(context).textTheme.headlineSmall
                        : Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                // User Input Fields 1, college code, branch code, year, study year
                const UserInput1(),

                const SizedBox(height: 30),
                // User Input Fields 2, roll no to rll no, semester
                const UserInput2(),
                const SizedBox(height: 50),
                // Generate button
                Obx(
                  () => (studentsListData.users.isNotEmpty)
                      ? PrimaryButton(
                          title: "Reset",
                          ontap: () {
                            takeUserInputController.clearFields();
                            studentsListData.users.clear();
                            dataFetchController.percentDownload.value = 0.0;
                            dataFetchController.completeFetchedData.clear();
                            dataFetchController.singleMapedStudent.clear();
                          })
                      : PrimaryButton(
                          title: "Generate",
                          ontap: () async {
                            if (!dataFetchController.isFetching.value) {
                              takeUserInputController.checkUserInput();
                              if (takeUserInputController.getFullRollNo() !=
                                  "") {
                                await dataFetchController.fetchResults(
                                  takeUserInputController.getFullRollNo(),
                                  takeUserInputController.getStartRollNo(),
                                  takeUserInputController.getEndRollNo(),
                                  takeUserInputController.getSemester(),
                                );
                              }
                            }
                          },
                        ),
                ),
                SizedBox(height: (screenWidth < 600) ? 60 : 80),

                Obx(
                  () => (studentsListData.users.isEmpty)
                      ? (dataFetchController.isFetching.value)
                          ? Container(
                              constraints: BoxConstraints(
                                maxWidth: (screenWidth < 600)
                                    ? (screenWidth < 350)
                                        ? 300
                                        : 400
                                    : 500,
                              ),
                              child: LinearPercentIndicator(
                                lineHeight: 20.0,
                                animation: true,
                                barRadius: const Radius.circular(10),
                                percent:
                                    dataFetchController.percentDownload.value,
                                progressColor:
                                    Theme.of(context).colorScheme.primary,
                                backgroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                                center: Text(
                                  "${(dataFetchController.percentDownload.value * 100).toInt()}%",
                                  style: (screenWidth < 600)
                                      ? Theme.of(context).textTheme.titleMedium
                                      : Theme.of(context).textTheme.titleLarge,
                                ),
                                animateFromLastPercent: true,
                                addAutomaticKeepAlive: true,
                              ),
                            )
                          : const SizedBox.shrink()
                      : const SizedBox.shrink(),
                ),

                Obx(
                  () => (dataFetchController.isFetching.value == false &&
                          dataFetchController.fetchDataError.value != "")
                      ? Center(
                          child: Text(
                            dataFetchController.fetchDataError.value,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // Data table
                Obx(
                  () => (studentsListData.users.isNotEmpty)
                      ? StudentListTable(
                          users: studentsListData.users,
                          columnHeaders: studentsListData.getColumnHeader(),
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => (studentsListData.users.isNotEmpty)
                      ? SizedBox(height: (screenWidth < 600) ? 50 : 80)
                      : const SizedBox.shrink(),
                ),
                //  Charts, percentage, subject wise fail
                Obx(
                  () => (studentsListData.users.isNotEmpty)
                      ? ChartsVisual(
                          users: studentsListData.users,
                          subjects: studentsListData.getSubjects(),
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => (studentsListData.users.isNotEmpty)
                      ? SizedBox(
                          height: (screenWidth < 600)
                              ? (screenWidth < 350)
                                  ? 40
                                  : 30
                              : 50)
                      : const SizedBox.shrink(),
                ),
                // Sheet export button
                Obx(
                  () => (studentsListData.users.isNotEmpty)
                      ? (isDownloading.value)
                          ? const CircularProgressIndicator()
                          : PrimaryButton(
                              title: "Export in Excel",
                              ontap: () {
                                downloadDynamicExcel(studentsListData.users,
                                    studentsListData.getColumnHeader());
                              },
                            )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => (downloadExcelError.value != "")
                      ? Center(
                          child: Text(
                            downloadExcelError.value,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
