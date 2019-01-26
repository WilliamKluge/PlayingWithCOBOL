      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. YOUR-PROGRAM-NAME.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
      * Alphebetic variable of 11 bytes to hold the text to print
      *      VALUE "Hello World".
           01 HELLO-PTR            USAGE POINTER.
       LINKAGE SECTION.
           01 HELLO                    PIC A(11).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            ALLOCATE FUNCTION LENGTH (HELLO) CHARACTERS
               RETURNING HELLO-PTR
            SET ADDRESS OF HELLO to HELLO-PTR
            MOVE "Hello World" TO HELLO
            DISPLAY HELLO
            STOP RUN.
       END PROGRAM YOUR-PROGRAM-NAME.
