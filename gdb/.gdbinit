add-auto-load-safe-path /

# tui enable

# 'rust-gdb' is simply a shell script that launches gdb with the 
# required configuration to load the rust pretty-printers if required.
# Some programs (namely debugging in nvim) want to call 'gdb'
# The following always loads the pretty-printers scripts.
# python
# import sys
# import os

# print("---- Manually add rust pretty-printers ----")

# # Discover script directory:
# stream = os.popen('rustc --print=sysroot')
# rustc_path = str(stream.read()).rstrip()
# if len(rustc_path.strip()) != 0:
#     rustc_etc_path = os.path.join(rustc_path, "lib", "rustlib", "etc")
#     print("Using sripts at '%s'" % rustc_etc_path)
#     # Add it to the python path:
#     sys.path.insert(0, rustc_etc_path)
#     # Configure GDB:
#     gdb.execute("add-auto-load-safe-path "+ str(rustc_path))
#     gdb.execute("dir "+ str(rustc_etc_path))
# else:
#     print("No rust pretty-printers found.")

# print("----              Done.                ----")

# end

set debuginfod enabled off
