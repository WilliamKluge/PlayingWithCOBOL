      ******************************************************************
      * Author: William Kluge
      * Date: 2019-01-24
      * Purpose: Playing with File IO in COBOL
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTING-IO.

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
      * "Boolean" for saying if we have reached the end of the file
           01 WS-EOF                   PIC A(1).

       PROCEDURE DIVISION.
           OPEN INPUT ITEM.
      * Keeps reading until our boolean has been set
               PERFORM UNTIL WS-EOF='Y'
      * Reads the line into the working storage
                   READ ITEM INTO WS-ITEM
                       AT END MOVE 'Y' TO WS-EOF
                       NOT AT END DISPLAY WS-ITEM
                   END-READ
               END-PERFORM.
           CLOSE ITEM.
       STOP RUN.

       END PROGRAM TESTING-IO.
