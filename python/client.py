import socket
s=socket.socket()
s.connect(('127.0.0.1',2000))   
data=s.recv(512)
print 'the data received is\n    ',data
s.send('hihi I am client')

sock2 = socket.socket()
sock2.connect(('127.0.0.1',2000))
data2=sock2.recv(512)
print 'the data received from server is\n   ',data2
sock2.send('client send use sock2')
sock2.close()

s.close()
