#!/usr/bin/python
import time
import vxi11
import matplotlib.pyplot as pl
  
instr =  vxi11.Instrument("10.40.254.53")
print(instr.ask("*IDN?"))
instr.write(":system:lock off")
instr.write(":waveform:format ascii")
pl.ion()
pl.show()

while 1:
  try:
    pl.clf()
    # ch1
    instr.write("acquire:points:digital")
    instr.write(":waveform:source channel1")
    # print(instr.ask(":waveform:points?"))
    data = eval(instr.ask(":waveform:data?"))
    yoff = eval(instr.ask(":channel1:offset?"))
    yvol = tuple(i-yoff for i in data)
    
    xinc = eval(instr.ask(":waveform:xincrement?"))
    xorg = eval(instr.ask(":waveform:xorigin?"))
    xpos = eval(instr.ask(":timebase:position?"))
    xtim = tuple((i*xinc+xorg+xpos)*1e6 for i in range(len(data)))
    
    sum = 0
    flag = pos1 = pos2 = pos3 = 0
    max_value = max(yvol)
    for i in range(len(data)):
       if yvol[i] > max_value*0.1 and flag == 0:
         pos1 = i
         flag = 1
       if yvol[i] < max_value*1.0 and flag == 1:
         pos3 = i
         break
    pos2 = int(2/1e6/xinc)
    # yvol[pos1:pos2] = 1

    # pl.subplot(3,1,1)
    # pl.plot(xtim, yvol, '-y', label='ICT1 '+str(yoff))
    pl.plot(xtim, yvol, '-y')
    
    # ch2
    instr.write(":waveform:source channel2")
    data = eval(instr.ask(":waveform:data?"))
    yoff = eval(instr.ask(":channel2:offset?"))
    yvol = tuple(i-yoff for i in data)
    pl.plot(xtim, yvol, '-g')
    
    # ch3
    instr.write(":waveform:source channel3")
    data = eval(instr.ask(":waveform:data?"))
    yoff = eval(instr.ask(":channel3:offset?"))
    yvol = tuple(i-yoff for i in data)
    pl.plot(xtim, yvol, '-b')
    
    pl.xlabel('us')
    pl.xlabel('ICT1 : '+str(yoff)+'nC      ICT2 : '+str(yoff)+'nC      ICT3 : '+str(yoff)+'nC')
    pl.ylabel('V')
    pl.title('Agilent Technologies Infiniium DSO9064A')
    pl.xlim((xinc+xorg+xpos)*1e6, (len(data)*xinc+xorg+xpos)*1e6)
    pl.grid(True)
    # pl.legend(loc='best', numpoints = 1 )
    pl.draw()
    
    time.sleep(0.1)
  except:
    # ValueError: x and y must have same first dimension
    print "timebase changing ... "
    # continue
