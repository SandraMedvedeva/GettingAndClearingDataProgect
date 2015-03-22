---
title: "CodeBook"
author: "Sandra Medvedeva"
date: "Sunday, March 22, 2015"
output: html_document
---

# Summary

The script `run_analysis.R`performs several steps.

1. We load and clear labels for activities and measurments.
2. We read and clear training data set.
3. We read and clear testing data set.
4. We merge train and test data.
5. We create a tidy, summarised dataset

More info are in comments inside R-script

# Variables

* `activity_labels` - labels for activities (factor)
* `measurment_labels` - lavels for measurment (columns' names)
* `train_subject`, `test_subject` - subjects' ids
* `train_activity`, `test_activity` - activity information
* `train_measurment...`, `test_measurment...` - temporary measurments datasets
* `train`, `test` - final measurments datasets
* `HAR_dataset` - merged dataset
* `HAR_grouping` - HAR_dataset with grouping by activity and id_subject added
* `tidy_set` - final set with only 40 rows (1 row for every pair activity~id_subject)