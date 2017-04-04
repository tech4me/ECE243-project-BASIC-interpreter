.include "defines.h"
.data
.global line_index_head
line_index_head:
.word line_index_array
.global line_index_current
line_index_current:
.word line_index_array

line_index_array:
#legal or not
.word 0
#line number
.word 0
#pointer to program text
.word 0
#the above is an example of how the array is structured
#save the memory for the array
.skip MAX_LINE_NUM * 3 - 3