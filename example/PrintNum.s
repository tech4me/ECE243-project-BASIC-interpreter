.ascii "10 LET A = 1\n"
.ascii "20 FOR I = 0 TO 9\n"
.ascii "25 LET B = 0\n"
.ascii "30 FOR J = 0 TO I + 1\n"
.ascii "40 LET D = (A - J)\n"
.ascii "50 LET K = J\n"
.ascii "60 IF K = 0 THEN GOTO 95 ELSE GOTO 70\n" 
.ascii "70 LET D = (D * 10)\n"
.ascii "80 LET K = (K - 1)\n"
.ascii "90 GOTO 60\n"
.ascii "95 LET B = (B + D)\n"
.ascii "100 NEXT J\n"
.ascii "110 LET C = ((B * 8) + A)\n"
.ascii "120 PRINT C; \"\" \n"
.ascii "130 PRINT \" = \" \n"
.ascii "140 PRINT B; \"\" \n"
.ascii "150 PRINT \" * 8 + \" \n"
.ascii "160 PRINT A; \"\r\"\n"
.ascii "170 LET A = (A + 1)\n"
.ascii "180 NEXT I\n"
.ascii "190 END\n"