#!/usr/bin/python

from reportlab import platypus
from reportlab.platypus import *
from reportlab.lib.styles import *
from reportlab.lib.enums import *
from reportlab.lib.pagesizes import *

import os
import datetime

now = datetime.datetime.today()
date = now.strftime("%h %d %Y %H:%M:%S")

def footer(canvas, doc):
  canvas.saveState()
  canvas.setFont('Helvetica', 9)
  canvas.drawString(20, 10, "Beam Diagnostics Group, Yan")
  canvas.drawString(290, 10, "- %d -" %doc.page)
  canvas.drawString(485, 10, date)
  canvas.restoreState()

styles = getSampleStyleSheet()
path = os.path.realpath(os.path.dirname(__file__))

doc = SimpleDocTemplate("report.pdf",pagesize=A4)
context = []

sty = styles["Title"]
sty.alignment = TA_CENTER
sty.fontName = "Helvetica"
sty.fontSize = 25
context.append(Spacer(0, 100))
#context.append(Paragraph('Beam Status Report', sty))
context.append(Paragraph('BEAM STATUS REPORT', sty))
context.append(Spacer(0, 30))
sty.fontSize = 18
context.append(Paragraph('Beam Diagnostics Group', sty))
context.append(PageBreak())

img = 'canvas.drawImage("'+path+'/x1.png", -20, -340, 480, 360)'
context.append(platypus.flowables.Macro(img))
img = 'canvas.drawImage("'+path+'/x2.png", -20, -720, 480, 360)'
context.append(platypus.flowables.Macro(img))
context.append(PageBreak())

context.append(Paragraph('continue ...', styles['Normal']))
img = 'canvas.drawImage("'+path+'/logo.jpg", 70, -200)'
context.append(platypus.flowables.Macro(img))
context.append(PageBreak())

context.append(Paragraph('continue ...', styles['Normal']))

doc.build(context, onLaterPages=footer)

