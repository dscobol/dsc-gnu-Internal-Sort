      ***********************************************************
      * Program name:    STCBEX01
      * Original author: David Stagowski
      *
      * Description: Example 01: Program to sort files.
      *    This version will sort with just USING and GIVING.

      *    This example will sort the records by City.

      * Maintenance Log
      * Date       Author        Maintenance Requirement
      * ---------- ------------  --------------------------------
      * 2023-03-10 dscobol       Created to learn.
      * 20xx-xx-xx               
      *
      **********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  STCBEX01.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      * SOURCE-COMPUTER.   IBM WITH DEBUGGING MODE.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INFile
           ASSIGN TO CUSTTXT
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT SORTFile
           ASSIGN TO SORTWK.

           SELECT OUTFile
           ASSIGN TO CUSTTXT2
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  INFile
           LABEL RECORDS ARE STANDARD
           RECORDING MODE IS F
           BLOCK CONTAINS 0 RECORDS.
           COPY CUSTOMER REPLACING ==:tag:== BY ==INFile==.

       SD  SORTFile.
           COPY CUSTOMER REPLACING ==:tag:== BY ==SORTFile==.

       FD OUTFile
           LABEL RECORDS ARE STANDARD
           RECORDING MODE IS F
           BLOCK CONTAINS 0 RECORDS.
           COPY CUSTOMER REPLACING ==:tag:== BY ==OUTFile==.

       WORKING-STORAGE SECTION.
       01 EOJ-Display-Messages.
           12 EOJ-End-Message PIC X(042) VALUE
              "*** Program STCBEX01 - End of Run Messages".

       PROCEDURE DIVISION.
       0000-Mainline.
           PERFORM 1000-Begin-Job.
           PERFORM 2000-Process.
           PERFORM 3000-End-Job.
           GOBACK.

       1000-Begin-Job.
      *    Because it is just USING and GIVING, file opening and 
      *    closing is not needed. The OS handles that.
      D     DISPLAY "1000-Begin-Job: ".
      D     DISPLAY "Normally, I would have something to do here".

       2000-Process.
           SORT SORTFile
              ON ASCENDING KEY
                 SORTFile-Cust-Last-Name
                USING INFile
                GIVING OUTFile.
           IF SORT-RETURN > 0
              DISPLAY '*** WARNING ***'
              DISPLAY '  SORT FAILED  '
           END-IF.

       3000-End-Job.
      D     DISPLAY "3000-End-Job: ".
           DISPLAY EOJ-End-Message.
