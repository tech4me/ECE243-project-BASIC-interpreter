.data
ERROR_MSG:
.string "Exiting!!!\n"

.text
.global exit
exit:

movia r4, ERROR_MSG
call print_to_debug

#reset sp
movia sp, 0x03FFFFFC

br main_reenable_it