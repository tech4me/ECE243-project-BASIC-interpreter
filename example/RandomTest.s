.ascii "10 LET A = (2*(50))\n"
.ascii "20 PRINT A;\"\r\"\n"
.ascii "30 LET B = 90\n"
.ascii "40 PRINT A * B;\"\r\"\n"
.ascii "50 IF A < 0 THEN LET A = 100 ELSE LET A = -100\n"
.ascii "60 PRINT A;\"\r\"\n"
.ascii "70 GOTO 90\n"
.ascii "75 PRINT \"hahaha\r\"\n"
.ascii "80 RETURN\n"
.ascii "90 PRINT B + 90; \"\r\"\n"
.ascii "100 FOR I = 0 TO 10\n"
.ascii "110 PRINT A;\"\r\"\n"
.ascii "120 NEXT I\n"
.ascii "130 GOSUB 75\n"
.ascii "140 END\n"