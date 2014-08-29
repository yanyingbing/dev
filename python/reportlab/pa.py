#!/usr/bin/python
import datetime
from reportlab.pdfgen import canvas   
from reportlab.lib.units import inch   

c = canvas.Canvas("hello.pdf")   
c.setFont("Helvetica", 10)   
c.drawString(20, 10, " Beam Diagnostics Group, Yan")   
now = datetime.datetime.today()
date = now.strftime("%h %d %Y %H:%M:%S")
c.drawCentredString(525, 10, date)   

c.drawImage("x1.png", 35, 10, width=520, preserveAspectRatio=True)
c.drawImage("x2.png", 35, -380, width=520, preserveAspectRatio=True)
c.showPage()   
c.save()  
