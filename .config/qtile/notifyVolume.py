import subprocess, pdb

filename = "hmm"

# print(subprocess.run(["ls", "{filename}"], calledProcess(
#     print(f"error there's no {filename}")
#     )))

# run = print(subprocess.run(f"cat {filename}", shell=True))
try: 
    run = subprocess.run(["cat", f"{filename}"], text=True)
    print(run)

# except subprocess.CalledProcessError as e:
except subprocess.CompletedProcess(returncode=1):
    raise f"error {e.returncode}"

# try:
#     ans = subprocess.check_output(["cat", f"{filename}"], text=True)
#     print(ans)
# 
# except subprocess.CalledProcessError as e:
#     print(f"Command failed with return code {e.returncode}")
