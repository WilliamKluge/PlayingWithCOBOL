      ******************************************************************
      * Author: William Kluge
      * Date: 2019-01-26
      * Purpose: Practicing using pointers in COBOL
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. POINTER-PRACTICE.
       DATA DIVISION.
           FILE SECTION.
           WORKING-STORAGE SECTION.
      * Pointer whose address we use to store data
           01 HELLO-PTR                USAGE POINTER.
           LINKAGE SECTION.
      * Linked variable (can be used with pointer) to hold value
           01 HELLO                    PIC A(11).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
      * Allocate the space needed to hold the variable with our pointer
            ALLOCATE FUNCTION LENGTH (HELLO) CHARACTERS
               RETURNING HELLO-PTR
      * Make HELLO actually use HELLO-PTR
            SET ADDRESS OF HELLO to HELLO-PTR
      * Change the value of HELLO (now we just use like regular variable)
            MOVE "Hello World" TO HELLO
            DISPLAY HELLO
            STOP RUN.
       END PROGRAM POINTER-PRACTICE.
