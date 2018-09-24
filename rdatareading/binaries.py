import utils as utl
import xdrlib
import gzip

#f = "/home/yuberth/file.rda"

#content = utl.readFile(f,"rb")

p = xdrlib.Packer()
p.pack_int(254)

print(p.get_buffer())


#up  = xdrlib.Unpacker(content)
#a = up.get_buffer()
#print(a)
