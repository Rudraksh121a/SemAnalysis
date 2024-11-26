import 'package:flutter/material.dart';
import 'package:get/get.dart';

void aboutDialog(BuildContext context) {
  Get.defaultDialog(
    title: "About SEManalysis",
    titleStyle: Theme.of(context).textTheme.headlineMedium,
    titlePadding:
        const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
    contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    content: Container(
      constraints: const BoxConstraints(
        maxHeight: 300,
        maxWidth: 500,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "SEManalysis is a Powerful tool designed to streamline the process of analyzing Student Performance. It fetches student data directly from the server, presents it in an Easy-to-Read DataTable, and provides insightful analytics on student Results. With SEManalysis, educators can quickly see the percentage of students who Passed or Failed, and easily identify how many students struggled in specific subjects. This software Saves Countless Hours typically spent on Manual Result Analysis, making it an indispensable tool for institutions focused on student success.",
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.justify,
            ),
            Text(
              "Thank You For Using",
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "\u00A9 Copyright 2024 - SEManalysis\nDeveloped By - Rudraksh kanungo & Harsh Kumar Gupta\nSeptember 2024",
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Close",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
