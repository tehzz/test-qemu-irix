#!/usr/bin/env python3

import argparse
import subprocess
import sys
import platform
from pathlib import PurePath

ido_versions     = ["5.3", "7.1"]
opt_levels       = ["g", "O1", "O2", "O3"]
mips_isets       = ["mips1", "mips2"]
standard_chksums = "standard.sha1"
standard_info    = "standard_invocation.txt"
build_base       = "build"
build_dir_prefix = "ido"  
output_prefix    = "output"

#      Ver,  Opt, Insn Set
illegal_configurations = [
    ("7.1", "O3", None),
]

def generate_configurations():
    for v in ido_versions:
        for o in opt_levels:
            for iset in mips_isets:
                if is_illegal_config(v,o,iset):
                    continue
                yield (v, o, iset)

def is_illegal_config(ver, opt, iset):
    for v, o, i in illegal_configurations:
        check = (v is None or v == ver) \
            and (o is None or o == opt) \
            and (i is None or i == iset)
        if check: return True
    return False

def run_compiler(make, defines):
    for v, o, iset in generate_configurations():
        subprocess.run([
            make, 
            f"IDO={v}", 
            f"OPT={o}", 
            f"MIPS_SET={iset}",
        ] + defines)

def generate_chksums(invocation, qemu):
    bins = []
    for v, o, iset in generate_configurations():
        build_dir = f"{build_dir_prefix}_{v}_{o}_{iset}"
        output_bin = f"{output_prefix}_{v}_{o}_{iset}.bin"
        binary = PurePath(build_base,build_dir,output_bin)
        bins.append(binary.as_posix())
    
    chksums = subprocess.run(["shasum"] + bins, capture_output=True, text=True)

    if chksums.returncode == 0:
        with open(standard_chksums, "w") as out:
            out.write(chksums.stdout)
        
        with open(standard_info, "w") as info:
            info.write(platform.platform())
            info.write("\n")
            info.write(invocation)
            info.write("\n")
            info.write(subprocess.run([qemu, "--version"], capture_output=True, text=True).stdout)
        
        return True
    else:
        sys.stderr.write("issue calculating shasums\n")
        sys.stderr.write(chksums.stderr)

        return False

def validate_chksums():
    return subprocess.run(["shasum", "-c", standard_chksums]).returncode

def make_clean(make, defines):
    return subprocess.run([make, "clean"] + defines).returncode

def get_args():
    parser = argparse.ArgumentParser(description="Compile sample code to test qemu-irix changes")
    parser.add_argument("-m", "--make", default="make",
        help="path to make executable (default \"make\")")
    parser.add_argument("-q", "--qemu", default="qemu_irix",
        help="path to qemu-irix executable (default \"qemu-irix\")")
    parser.add_argument("-c","--cpp", default="mips64-elf-cpp",
        help="path to c preprocessor (default \"mips64-elf-cpp\"")
    parser.add_argument("-s","--standard", action='store_true',
        help="record the SHA checksum for produced binary files")
    parser.add_argument("--clean", action='store_true',
        help="make clean")
    
    return parser.parse_args()

def format_make_options(qemu, cpp):
    output = []
    if qemu is not None:
        output.append(f"QEMU_IRIX=\"{qemu}\"")
    if cpp is not None:
        output.append(f"CPP=\"{cpp}\"")
    
    return output
        
def main():
    if platform.system() == "Windows":
        sys.stderr.write("qemu-irix is not supported on Windows\n")
        return -1
    
    invocation = " ".join(sys.argv)
    args = get_args()
    make_defines = format_make_options(args.qemu, args.cpp)

    if args.clean:
        return make_clean(args.make, make_defines)

    run_compiler(args.make, make_defines)

    if args.standard:
        if not generate_chksums(invocation, args.qemu):
            return -1
    else:
        ret = validate_chksums()
        if ret == 0:
            print("All Checksums: OK")
        return ret
        

if __name__ == "__main__":
    main()
