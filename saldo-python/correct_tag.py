# Fish for wheel platform tag matching current os
# Hopefully generally works on macOS and Linux

import sysconfig
import platform


tentative = sysconfig.get_platform().replace('-', '_').replace('.', '_')

if platform.system() == "Darwin":
    version = platform.mac_ver()[0].split(".")[0]
    prefix = tentative.split("_")[0]
    postfix = "_".join(tentative.split("_")[2:])
    tentative = prefix + "_" + version + "_0_" + postfix

print(tentative)
