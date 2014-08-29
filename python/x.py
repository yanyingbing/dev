#!/usr/bin/python
from couchbase import *
import cothread
from cothread.catools import *
import bz2
from numpy import *
import matplotlib.pyplot as pl

c = Couchbase.connect(bucket='beer-sample', host='localhost')
try: 
#  xa = bz2.compress(caget("test:CH1_WAVEFORM"),2)
#  c.set("xa", xa, format=FMT_AUTO)
  xb = c.get("xf")
  xc = frombuffer(bz2.decompress(xb.value), dtype=float)
except:
  print "error"

pl.plot(xc)
#pl.xlabel('us')
#pl.title('couchbase')
pl.grid(True)
#pl.savefig("xx.eps")
pl.savefig("xx.png",dpi=200)
#pl.show()

#http://docs.couchbase.com/couchbase-sdk-python-1.0/tutorial/
#http://www.couchbase.com/communities/python/getting-started
