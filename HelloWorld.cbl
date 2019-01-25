      ******************************************************************
      * Author: William Kluge
      * Date: 2019-01-24
      * Purpose: Testing out COBOL stufF
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTING-COBOL.

       DATA DIVISION.
           FILE SECTION.
           WORKING-STORAGE SECTION.
      * Alphebetic variable of 11 bytes to hold the text to print
           01 WS-HELLO                 PIC A(11) VALUE "Hello World".
      * Holds the count of iterations of the loop
           01 WS-CNT                   PIC 9(1)  VALUE 0.

       PROCEDURE DIVISION.
      * Will loop through HELLO-LOOP until WS-CNT is 5
           MAIN-PROCEDURE.
           PERFORM HELLO-LOOP WITH TEST BEFORE UNTIL WS-CNT EQUALS 5.
           STOP RUN.
      * Prints WS-HELLO and adds one to WS-CNT
           HELLO-LOOP.
           DISPLAY WS-HELLO.
           ADD 1 TO WS-CNT.

       END PROGRAM TESTING-COBOL.
