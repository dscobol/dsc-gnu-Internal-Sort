      ***********************************************************
      * Program name:    STCBEX02
      * Original author: David Stagowski
      *
      * Description: Example 02: Program to sort files.
      *    This version will use an Input Procedure and GIVING.

      *    This example will exclude the states Illinois and New York,
      *    and then sort the remaining records by City.

      * Maintenance Log
      * Date       Author        Maintenance Requirement
      * ---------- ------------  --------------------------------
      * 2023-03-10 dscobol       Created to learn.
      * 20xx-xx-xx               
      *
      **********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  STCBEX02.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      * SOURCE-COMPUTER.   IBM WITH DEBUGGING MODE.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INFile
           ASSIGN TO CUSTTXT
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-INFile-Status.

           SELECT SORTFile
           ASSIGN TO SORTWK.

           SELECT OUTFile
           ASSIGN TO CUSTTXT2
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-OUTFile-Status.

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
       01  WS-FILE-STATUS.
           COPY WSFST REPLACING ==:tag:== BY ==INFile==.
           COPY WSFST REPLACING ==:tag:== BY ==SORTFile==.
           COPY WSFST REPLACING ==:tag:== BY ==OUTFile==.

       01  WS-File-Counters.
           12 FD-INFile-Record-Cnt         PIC S9(4) COMP VALUE ZERO.
           12 SD-SORTFile-Record-Cnt       PIC S9(4) COMP VALUE ZERO.
           12 FD-OUTFile-Record-Cnt        PIC S9(4) COMP VALUE ZERO.

       01 EOJ-Display-Messages.
           12 EOJ-End-Message PIC X(042) VALUE
              "*** Program STCBEX02 - End of Run Messages".

       PROCEDURE DIVISION.
       0000-Mainline.
           PERFORM 1000-Begin-Job.
           PERFORM 2000-Process.
           PERFORM 3000-End-Job.
           GOBACK.

       1000-Begin-Job.
      D     DISPLAY "1000-Begin-Job: ".
      *    Note: Open input here, close at end of Input-Procedure.
           OPEN INPUT INFile.
           PERFORM 5000-Read-INFile.

       2000-Process.

           SORT SORTFile
              ON ASCENDING KEY
              SORTFILE-Cust-State,
              SORTFILE-Cust-State
                 INPUT  PROCEDURE 2100-Input-Procedure
                 GIVING OUTFILE.
           IF SORT-RETURN > 0
              DISPLAY '*** WARNING ***'
              DISPLAY '  SORT FAILED  '
           END-IF.

       2100-Input-Procedure.
           PERFORM UNTIL WS-INFile-EOF
              PERFORM 2110-Process-INFile-Record
              PERFORM 5000-Read-INFile
           END-PERFORM.
           CLOSE INFile.

      *    Whatever processing that needs to place before the
      *       record goes to be sorted takes place in this
      *       paragraph.
       2110-Process-INFile-Record.
           IF INFile-Cust-State = "Illinois" OR "New York"
              NEXT SENTENCE
           ELSE
              MOVE INFile-Customer-Record TO
                 SORTFile-Customer-Record
              PERFORM 8000-Release-SortFile
           END-IF.

       3000-End-Job.
      D     DISPLAY "3000-End-Job: ".
           DISPLAY EOJ-End-Message.

       5000-Read-INFile.
           READ INFile
              AT END SET WS-INFile-EOF TO TRUE
           END-READ.
           IF WS-INFile-Good
              ADD +1 TO FD-INFile-Record-Cnt
           ELSE
              IF WS-INFile-EOF
                 NEXT SENTENCE
              ELSE
                 DISPLAY "** ERROR **: 5000-Read-INFile"
                 DISPLAY "Read INFile Failed."
                 DISPLAY "File Status: " WS-INFile-Status
                 CLOSE INFile
                 MOVE 8 TO RETURN-CODE
                 GOBACK 
              END-IF
           END-IF.

       8000-Release-SortFile.
           RELEASE SORTFile-Customer-Record.
