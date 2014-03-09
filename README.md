queries-ap926
=============

For testing query performance on insert/update

```

DIS MAGIC RESULTS WITH 1,000 RECORDS
-------------------------------------
2014-03-08T14:17:56-0500 app.0: Truncating table first...
2014-03-08T14:17:56-0500 app.0: Generating sessions...
2014-03-08T14:17:56-0500 app.0: Entering loop number 1 with 1000 records
2014-03-08T14:17:56-0500 app.0: Running insert and update queries...
2014-03-08T14:18:44-0500 app.0: Total updates => 0, inserts => 1001 for 1000 records in that loop. Running time: 48.51906
2014-03-08T14:18:44-0500 app.0: Finished loop number 1. Next loop in 2 seconds
2014-03-08T14:18:46-0500 app.0: Entering loop number 2 with 1000 records
2014-03-08T14:18:46-0500 app.0: Running insert and update queries...
2014-03-08T14:19:32-0500 app.0: Total updates => 1001, inserts => 0 for 1000 records in that loop. Running time: 45.89265
2014-03-08T14:19:32-0500 app.0: Finished loop number 2. Next loop in 2 seconds
2014-03-08T14:19:34-0500 stackato.dea.0: Stopping application 'queries-carlitos-way' on DEA a9327d
2014-03-08T14:19:34-0500 app.0: Done

SE2 RESULTS WITH 4,000 RECORDS
-------------------------------------
2014-03-08T13:40:29-0500 app.0: Truncating table first...
2014-03-08T13:40:29-0500 app.0: Generating sessions...
2014-03-08T13:40:29-0500 app.0: Entering loop number 1 with 4000 records
2014-03-08T13:40:29-0500 app.0: Running insert and update queries...
2014-03-08T13:40:38-0500 app.0: Total updates => 0, inserts => 4001 for 4000 records in that loop. Running time: 8.70381
2014-03-08T13:40:38-0500 app.0: Finished loop number 1. Next loop in 2 seconds
2014-03-08T13:40:40-0500 app.0: Entering loop number 2 with 4000 records
2014-03-08T13:40:40-0500 app.0: Running insert and update queries...
2014-03-08T13:40:51-0500 app.0: Total updates => 4001, inserts => 0 for 4000 records in that loop. Running time: 11.30768
2014-03-08T13:40:51-0500 app.0: Finished loop number 2. Next loop in 2 seconds
2014-03-08T13:40:53-0500 app.0: Entering loop number 3 with 4000 records
2014-03-08T13:40:53-0500 app.0: Running insert and update queries...
2014-03-08T13:41:08-0500 app.0: Total updates => 4001, inserts => 0 for 4000 records in that loop. Running time: 15.06176
2014-03-08T13:41:08-0500 app.0: Finished loop number 3. Next loop in 2 seconds
2014-03-08T13:41:10-0500 app.0: Entering loop number 4 with 4000 records
2014-03-08T13:41:10-0500 app.0: Running insert and update queries...
2014-03-08T13:41:21-0500 app.0: Total updates => 4001, inserts => 0 for 4000 records in that loop. Running time: 10.48444
2014-03-08T13:41:21-0500 app.0: Finished loop number 4. Next loop in 2 seconds
2014-03-08T13:41:23-0500 app.0: Entering loop number 5 with 4000 records
2014-03-08T13:41:23-0500 app.0: Running insert and update queries...
2014-03-08T13:41:33-0500 app.0: Total updates => 4001, inserts => 0 for 4000 records in that loop. Running time: 10.50967
2014-03-08T13:41:33-0500 app.0: Finished loop number 5. Next loop in 2 seconds
2014-03-08T13:41:35-0500 app.0: Done

MR1 RESULTS WITH 4,000 RECODS
-------------------------------------
2014-03-08T13:25:49-0500 app.0: Truncating table first...
2014-03-08T13:25:49-0500 app.0: Generating sessions...
2014-03-08T13:25:49-0500 app.0: Entering loop number 1 with 4000 records
2014-03-08T13:25:49-0500 app.0: Running insert and update queries...
2014-03-08T13:26:02-0500 app.0: Total updates => 0, inserts => 4001 for 4000 records in that loop. Running time: 13.05527
2014-03-08T13:26:02-0500 app.0: Finished loop number 1. Next loop in 2 seconds
2014-03-08T13:26:04-0500 app.0: Entering loop number 2 with 4000 records
2014-03-08T13:26:04-0500 app.0: Running insert and update queries...
2014-03-08T13:26:16-0500 app.0: Total updates => 4001, inserts => 0 for 4000 records in that loop. Running time: 11.34073
2014-03-08T13:26:16-0500 app.0: Finished loop number 2. Next loop in 2 seconds
2014-03-08T13:26:18-0500 app.0: Entering loop number 3 with 4000 records
2014-03-08T13:26:18-0500 app.0: Running insert and update queries...
2014-03-08T13:26:33-0500 app.0: Total updates => 4001, inserts => 0 for 4000 records in that loop. Running time: 15.47313
2014-03-08T13:26:33-0500 app.0: Finished loop number 3. Next loop in 2 seconds
2014-03-08T13:26:35-0500 app.0: Entering loop number 4 with 4000 records
2014-03-08T13:26:35-0500 app.0: Running insert and update queries...
2014-03-08T13:26:49-0500 app.0: Total updates => 4001, inserts => 0 for 4000 records in that loop. Running time: 13.47849
2014-03-08T13:26:49-0500 app.0: Finished loop number 4. Next loop in 2 seconds
2014-03-08T13:26:51-0500 app.0: Entering loop number 5 with 4000 records
2014-03-08T13:26:51-0500 app.0: Running insert and update queries...
2014-03-08T13:27:04-0500 app.0: Total updates => 4001, inserts => 0 for 4000 records in that loop. Running time: 13.82271
2014-03-08T13:27:04-0500 app.0: Finished loop number 5. Next loop in 2 seconds
2014-03-08T13:27:06-0500 stackato.dea.0: Stopping application 'queries-carlitos-way' on DEA 80cdd4
2014-03-08T13:27:06-0500 app.0: Done
```
