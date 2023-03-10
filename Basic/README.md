# dsc-gnu-Internal-Sort Basic

## List of program names and descriptions:

| Program  | Description                               | 
| :------  | :---------------------------------------- | 
|          |                                           |
| STCBEX01 | This program will sort with just USING and GIVING.|
| STCBEX02 | This program will sort using an Input Procedure and GIVING.|
| STCBEX03 | This program will sort using USING and an Output Procedure.|
| STCBEX04 | This program will sort using an Input Procedure and an Output Procedure.|


Programs STCBEX02, STCBEX03, and STCBEX04 will produce the same output file.

They just create it using different Procedures.

## Directory Structure:

This is the directory structure use to create, compile and run these programs.
```
.
├── bin
├── cbl
├── cpy
├── data
├── jcl
```

The bin directory is not present as it is excluded by the .gitignore file.

## Running the examples:

Create the missing directory:
```
mkdir bin
```

CD into the jcl directory.

These "jobs" are "compile, link and go" scripts.

Run anyone of them and check the output in the /data directory.
