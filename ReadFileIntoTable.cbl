      ******************************************************************
      * Author: William Kluge
      * Date: 2019-01-24
      * Purpose: Reading a file into a table
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTING-TABLES.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
      * This is the file we are working with
           SELECT ITEM ASSIGN TO 'magicitems.txt'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
           FD ITEM.
           01 ITEM-FILE.
      * The 50 is based on the largest line in the file (I think 46)
               05 NAME                 PIC A(50).

           WORKING-STORAGE SECTION.
           01 WS-ITEM.
               05 WS-NAME              PIC A(50).
           01 WS-REC-CNT               PIC 9(3) VALUE 0.
           01 WS-ITEM-TABLE OCCURS 0 TO 1000 TIMES
           DEPENDING ON WS-REC-CNT     PIC A(50).
      * 10 bytes for up to 1024 entries
           01 WS-TABLE-INDEX           PIC 9(10).
      * "Boolean" for saying if we have reached the end of the file
           01 WS-EOF                   PIC A(1).

       PROCEDURE DIVISION.
           MAIN-PROCEDURE.
           OPEN INPUT ITEM.
      * Keeps reading until our boolean has been set
               PERFORM UNTIL WS-EOF='Y'
                   READ ITEM INTO WS-ITEM
                       AT END
                           MOVE 'Y' TO WS-EOF
                       NOT AT END
      * Add one to our record count and move value to table
                           ADD 1 TO WS-REC-CNT
                           MOVE WS-ITEM TO WS-ITEM-TABLE (WS-REC-CNT)
                   END-READ
               END-PERFORM.
           CLOSE ITEM.
           PERFORM SHOW-TABLE-ENTRIES.
           STOP RUN.

           SHOW-TABLE-ENTRIES.
      * Go through the array displaying the values
           PERFORM WITH TEST AFTER VARYING WS-TABLE-INDEX FROM 1 BY 1
           UNTIL WS-TABLE-INDEX = WS-REC-CNT
               DISPLAY WS-ITEM-TABLE (WS-TABLE-INDEX)
           END-PERFORM.

       END PROGRAM TESTING-TABLES.
