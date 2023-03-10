      ***********************************************************
      * Copybook name: WSFST
      * Original author: David Stagowski
      *
      * Description: A basic File Status copybook.
      *
      * Typical Use: Within the Working-Storage Section:
      *
      * 01  WS-FILE-STATUS.
      *     COPY WSFST REPLACING ==:tag:== BY ==INFILE==.
      *        where "INFILE" would be whatever you need it to be.
      *
      *
      * Maintenance Log
      * Date       Author        Maintenance Requirement
      * ---------- ------------  --------------------------------
      * 2023-03-10 dscobol       Created to learn.
      * 20xx-xx-xx               
      *
      **********************************************************
           12 WS-:tag:-Status            pic x(2).
              88 WS-:tag:-EOF            value "10".
              88 WS-:tag:-Good           value "00".
              88 WS-:tag:-Okay           values "00" "10".
