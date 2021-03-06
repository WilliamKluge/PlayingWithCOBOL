      ******************************************************************
      * Author: William Kluge
      * Date: 2019-01-26
      * Purpose: Reading a file into a dynamically allocated table
      * Tectonics: cobc
      * Huge shoutout to Simon Sobisch for how to do this (link)
      * https://sourceforge.net/p/open-cobol/discussion/cobol/thread/ (->)
      * 5766ecab/#b72c
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.      TESTING-DYNAMIC-TABLES.
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
           01  NUMBER-OF-ROWS          PIC 9(08).
           01  CURRENT-MAX             PIC 9(08).
           01  DATA-PTR                USAGE POINTER.
      * 10 bytes for up to 1024 entries
           01 WS-TABLE-INDEX           PIC 9(10).
      * "Boolean" for saying if we have reached the end of the file
           01 WS-EOF                   PIC A(1).
           01 WS-ITEM.
               05 WS-NAME              PIC A(50).

           LINKAGE SECTION.
           01  MY-TABLE BASED.
               03  MY-ROW     OCCURS 0 TO UNBOUNDED TIMES
                                 DEPENDING ON NUMBER-OF-ROWS.
                   05                  PIC A(50).
           01  ALLOC-TABLE BASED.
               03  ALLOC-ROW     OCCURS 0 TO UNBOUNDED TIMES
                                 DEPENDING ON CURRENT-MAX.
                   05                  PIC A(50).

       PROCEDURE DIVISION.
           MAIN-PROGRAM.
           MOVE 1 TO CURRENT-MAX
           ALLOCATE FUNCTION LENGTH (ALLOC-TABLE) CHARACTERS
               RETURNING DATA-PTR
           SET ADDRESS OF ALLOC-TABLE TO DATA-PTR
           SET ADDRESS OF MY-TABLE    TO DATA-PTR
           MOVE 0 TO NUMBER-OF-ROWS.

           OPEN INPUT ITEM.
      * Keeps reading until our boolean has been set
           PERFORM UNTIL WS-EOF='Y'
               READ ITEM INTO WS-ITEM
                   AT END
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
      * Add one to our record count and move value to table
                       PERFORM ADD-SINGLE-ENTRY
                   END-READ
               END-PERFORM.
           CLOSE ITEM.
           PERFORM SHOW-TABLE-ENTRIES.
           STOP RUN.

           PERFORM SHOW-TABLE-ENTRIES.
           FREE ADDRESS OF ALLOC-TABLE
           STOP RUN.

           ADD-SINGLE-ENTRY.
           IF NUMBER-OF-ROWS = CURRENT-MAX
              ADD 1 TO CURRENT-MAX
              ALLOCATE FUNCTION LENGTH (ALLOC-TABLE) CHARACTERS
                    RETURNING DATA-PTR
              SET ADDRESS OF ALLOC-TABLE TO DATA-PTR
              MOVE MY-TABLE TO ALLOC-TABLE
              FREE ADDRESS OF MY-TABLE *> don't forget that ;-)
              SET ADDRESS OF MY-TABLE    TO DATA-PTR
           END-IF
           ADD 1 TO NUMBER-OF-ROWS
           MOVE WS-NAME to MY-ROW (NUMBER-OF-ROWS).

           SHOW-TABLE-ENTRIES.
      * Go through the array displaying the values
           PERFORM WITH TEST AFTER VARYING WS-TABLE-INDEX FROM 1 BY 1
           UNTIL WS-TABLE-INDEX = NUMBER-OF-ROWS
               DISPLAY ALLOC-ROW of ALLOC-TABLE (WS-TABLE-INDEX)
           END-PERFORM.

       END PROGRAM TESTING-DYNAMIC-TABLES.
