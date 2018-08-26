org 0h
start: clr p1.0
call delay	
setb p1.0
call delay	
sjmp start	
delay: mov R1,#100
lop1: mov R2,#60
lop2: mov R3,#20
lop3: djnz R3,lop3
      djnz R2,lop2
      djnz R1,lop1
ret
end