.data
.global ASCII_LIST_PTR

ASCII_LIST_PTR:
.word ASCII_LIST

ASCII_LIST:
.skip 21 
.byte 'Q' #21
.byte 0x031 #22: number 1
.skip 3 #23,24,25
.byte 'Z' #26
.byte 'S' #27
.byte 'A' #28
.byte 'W' #29
.byte 0x032 #30: number 2
.skip 2
.byte 'L' #33
.byte 'X' #34
.byte 'D' #35
.byte 'E' #36
.byte 0x034 #37: number 4 
.byte 0x033 #38: number 3 
.skip 2
.byte 0x020 #41: SPACE key 
.byte 'V' #42
.byte 'F' #43
.byte 'T' #44
.byte 'R' #45
.byte 0x035 #46: number 5 
.skip 2
.byte 'N' #49
.byte 'B' #50
.byte 'H' #51
.byte 'G' #52
.byte 'Y' #53
.byte 0x036 #54: number 6 
.skip 3
.byte 'M' #58
.byte 'J' #59
.byte 'U' #60
.byte 0x037 #61: number 7 
.byte 0x038 #62: number 8
.skip 2
.byte 0x02c  #65: ,
.byte 'K' #66
.byte 'I' #67
.byte 'O' #68
.byte 0x030 #69: number 0 
.byte 0x039 #70: number 9
.skip 2
.byte 0x02e #73: . 
.byte 0x02f #74: /
.byte 'L' #75
.byte 0x03b #76: ;
.byte 'P' #77
.byte 0x02d #78: -
.skip 3
.byte 0x027 #82: '
.skip 1
.byte 0x05b #84: [
.byte 0x03d #85: =
.skip 4
.byte 0x0A #ENTER key, 90
.byte 0x05d #91: ]
.skip 1 
.byte 0x05c #93: \
.skip 8
.byte 0x08 #Backspace key, 102