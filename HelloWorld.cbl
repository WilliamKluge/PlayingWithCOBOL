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
       01 WS-HELLO                     PIC A(11) VALUE "Hello World".
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY WS-HELLO.
            STOP RUN.
       END PROGRAM TESTING-COBOL.
