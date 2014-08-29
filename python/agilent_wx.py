#!/usr/bin/python
import wx
import vxi11
from matplotlib.figure import Figure 
from matplotlib.backends.backend_wxagg import FigureCanvasWxAgg as FigureCanvas

class MyFrame(wx.Frame):
  def __init__(self):
    wx.Frame.__init__(self, None, -1, "Agilent", (-1, -1), (640, 510))
    self.pl = MatplotPanel(self)
    
    self.gs = wx.GridSizer(1, 4)
    self.gs.AddMany([(wx.StaticText(self, -1, ''), 0, wx.EXPAND),
      (wx.StaticText(self, -1, ''), 0, wx.EXPAND),
      (wx.StaticText(self, -1, ''), 0, wx.EXPAND),
      (wx.Button(self, 1, 'Update'), 0, wx.EXPAND)])
   
    box = wx.BoxSizer(wx.VERTICAL)
    box.Add(self.pl, 0, wx.EXPAND)
    box.Add(self.gs, 0, wx.EXPAND)
    self.SetSizer(box)
    self.Centre()
    self.Bind(wx.EVT_BUTTON, self.Update, id=1)
    
  def Update(self, event):
    self.pl.Acquire()
    
class MatplotPanel(wx.Panel):
  def __init__(self, parent):
    wx.Panel.__init__(self, parent)
    self.figure = Figure()
    self.axes = self.figure.add_subplot(111)
    
    self.instr =  vxi11.Instrument("10.40.254.53")
    self.instr.write(":waveform:format ascii")
    
    self.x = None
    self.y = None
    self.axes.plot(self.x, self.y)
    self.canvas = FigureCanvas(self, -1, self.figure)
    
  def Acquire(self):
    self.instr.write(":waveform:source channel1")
    data = eval(self.instr.ask(":waveform:data?"))
    offset = eval(self.instr.ask(":channel1:offset?"))
    self.y = tuple(i-offset for i in data)
    
    xinc = eval(self.instr.ask(":waveform:xincrement?"))
    xorg = eval(self.instr.ask(":waveform:xorigin?"))
    self.x = tuple((i*xinc+xorg)*1e6 for i in range(len(data)))
    
    self.axes.clear()
    self.axes.plot(self.x, self.y, '-r')
    self.axes.set_title("Agilent Technologies Infiniium DSO9064A")
    self.axes.set_xlabel("us")
    self.axes.set_ylabel("Volt")
    self.axes.set_xlim((xinc+xorg)*1e6, (len(data)*xinc+xorg)*1e6)
    self.axes.set_ylim(-4, 4)
    self.axes.grid()
    self.canvas = FigureCanvas(self, -1, self.figure)
    
if __name__ == '__main__':
  app = wx.PySimpleApp() 
  frame = MyFrame()
  frame.Show()
  app.MainLoop()
