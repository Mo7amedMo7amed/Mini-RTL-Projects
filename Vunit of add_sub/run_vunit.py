from os.path import join, dirname
from vunit import VUnit

root = dirname (__file__) ## the root is the directory of the current file
VU = VUnit.from_argv()   ## ui is a coloured command line interface 
VU.add_vhdl_builtins()
lib = VU.add_library ("lib")
lib.add_source_file (join (root, "add_sub.vhd"), vhdl_standard = '2008')
lib.add_source_file (join (root, "tb_behav.vhd"), vhdl_standard = '2008')

VU.main ()