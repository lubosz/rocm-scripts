## Created by    : Paresh Patel
## Creation Date : 04/12/2018
## Description   : Script is for Testing OpenCL and Hip profiling with rocm-profiler(RCP)

import os
import sys
import re

if(len(sys.argv) == 1):
        print('The command line arguments are:[Help]-pass below testcases in command line')
        print "Please select any below tests and pass in command line"
        print "rcp_opencl_test_case_1"
        print "rcp_opencl_test_case_2"
        print "rcp_opencl_test_case_3"
        print "rcp_opencl_test_case_4"
        print "rcp_opencl_test_case_5"
        print "rcp_opencl_test_case_6"
        print "rcp_opencl_test_case_7"
        print "rcp_opencl_test_case_8"
        print "rcp_opencl_test_case_9"
        print "rcp_hip_test_case_1"
        print "rcp_hip_test_case_2"
        print "rcp_hip_test_case_3"
        print "rcp_hip_test_case_4"
        print "rcp_hip_test_case_5"
        print "All_Tests"

os.system("rm -rf Results.ini");
os.system("rm -f rcp_opencl_test_case*")
os.system("rm -f rcp_hip_test_case*")

cwd=os.getcwd()
Y="Y"
fo=open("Results.ini","a+");
steps=0

list=["rcp_opencl_test_case_1",
	"rcp_opencl_test_case_2",
	"rcp_opencl_test_case_3",
	"rcp_opencl_test_case_4",
	"rcp_opencl_test_case_5",
	"rcp_opencl_test_case_6",
	"rcp_opencl_test_case_7",
	"rcp_opencl_test_case_8",
	"rcp_opencl_test_case_9",
	"rcp_hip_test_case_1",
	"rcp_hip_test_case_2",
	"rcp_hip_test_case_3",
	"rcp_hip_test_case_4",
	"rcp_hip_test_case_5"]

fo.write("[STEPS]\nNumber=%.3d\n"%(len(list)+1))

if not os.path.exists("%s/Desktop/RCP"%os.getenv("HOME")):
	os.chdir("%s/Desktop"%os.getenv("HOME"))
	os.system("mkdir RCP")
	os.chdir("%s"%cwd)
else:
	os.system("sudo rm -rf %s/Desktop/RCP"%os.getenv("HOME"))
	os.chdir("%s/Desktop"%os.getenv("HOME"))
        os.system("mkdir RCP")
        os.chdir("%s"%cwd)

os.chdir("%s/Desktop/RCP"%os.getenv("HOME"))
os.system("echo %s | sudo apt-get autoremove rocm-profiler"%Y)
os.system("echo %s | sudo apt-get install rocm-profiler"%Y)
os.system("echo %s | sudo apt-get install cxlactivitylogger"%Y)
os.chdir("%s"%cwd)

if not os.path.exists("/opt/rocm/profiler/bin/rcprof"):
        steps = steps + 1
        fo.write("\n[STEP_%.3d]\nDescription=rocm-profiler(RCP) build\nStatus=Failed\n"%steps)
else:
        steps = steps + 1
        fo.write("\n[STEP_%.3d]\nDescription=rocm-profiler(RCP) build\nStatus=Passed\n"%steps)

if not os.path.exists("/mnt/hsa/ROCm-TestApps"):
	if not os.path.exists("/mnt/hsa"):
		os.chdir("/mnt")
		os.system("mkdir hsa")
		os.chdir("%s"%cwd)
	os.system("mount  -t cifs -o username=taccuser,password=AH64_uh1 //hydinstreamcqe1/hsa /mnt/hsa")

i=1;
ext="log";
passing_count=0;
failing_count=0;
count=0;
# Below checking if OpenCL app is available or not
if not os.path.exists("%s/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16"%os.getenv("HOME")):
	os.system("sudo cp -rf /mnt/hsa/ROCm-TestApps/OpenCL/fp16_Lnx/SimpleConvolution $HOME/Desktop/RCP/.")

# Below checking if OpenCL app is available or not
if not os.path.exists("%s/Desktop/RCP/env_file"%os.getenv("HOME")):
        os.system("sudo cp -rf /mnt/hsa/ROCm-TestApps/rocm-profiler/env_file $HOME/Desktop/RCP/.")

# Below checking if OpenCL app is available or not
if not os.path.exists("/opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose"):
	os.chdir("/opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose")
	os.system("sudo make")
	os.chdir("%s"%cwd)

commands = {"rcp_opencl_test_case_1":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_1.atp -t -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_2":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_2.csv -p -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_3":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_3.atp -t -T -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_4":'/opt/rocm/profiler/bin/rcprof -a ~/Desktop/RCP/rcp_opencl_test_case_1.atp -T',
	"rcp_opencl_test_case_5":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_5.atp -D 10 -t -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_6":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_6.atp -D 10 -t -T -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_7":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_6.atp -d 5 -t -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_8":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_8.atp -d 5 -t -T -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_9":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_9.atp -d 3 -D 10 -t -T -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_hip_test_case_1":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_hip_test_case_1.csv -C -w /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose',
	"rcp_hip_test_case_2":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_hip_test_case_2.atp -A -w /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose',
	"rcp_hip_test_case_3":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_hip_test_case_3.atp -A -e HIP_PROFILE_API=1  -w /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose',
	"rcp_hip_test_case_4":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_hip_test_case_4.atp -A -E $HOME/Desktop/RCP/env_file  -w /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose',
	"rcp_hip_test_case_5":'/opt/rocm/profiler/bin/rcprof -o $HOME/Desktop/RCP/rcp_hip_test_case_5.atp -A -E $HOME/Desktop/RCP/env_file  -T -w /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose'}
try:
	#print commands["rocm-smi-vbios-ver"]
	j=0;
	for i in sys.argv:
		if(sys.argv[1] == "All_Tests"):
			for k in list:
				j=j+1;
				if(j>=1):
					k=k.rstrip('\r\n');
					command="%s>%s.%s"%(commands[k],k,ext)
					os.system(command);
                        		command1="%s.%s"%(k,ext);
                       			f1=command1.strip("\n");
        				steps = steps + 1
					#print ("%s"%f1)
					with open(f1) as open_file:
						data = open_file.read()
						searchObj = re.search("Failed|Error|Fail|failed*",data, re.M|re.I)
						if not searchObj:
                                        		#print "searchObj.group() : ", searchObj;
							fo.write("\n[STEP_%.3d]\nDescription=%s\nStatus=Passed\n"%(steps,k))
                                       			passing_count=passing_count+1;
                                		else:
							fo.write("\n[STEP_%.3d]\nDescription=%s\nStatus=Failed\n"%(steps,k))
                                        		failing_count=failing_count+1;
                                		count=count+1;
			break;
		else:
			j=j+1;
        		if(j>1):
	        		i=i.rstrip('\r\n');
				command="%s>%s.%s"%(commands[i],i,ext)
				print command;
				command1="%s.%s"%(i,ext);
				f1=command1.strip("\n");
        			steps = steps + 1
				with open(f1) as open_file:
                        		data = open_file.read()
					searchObj = re.search("Failed|Error|Fail|failed*",data, re.M|re.I)
					if searchObj:
                        			#print "searchObj.group() : ", searchObj;
						fo.write("\n[STEP_%.3d]\nDescription=%s\nStatus=Passed\n"%(steps,i))
                        			passing_count=passing_count+1;
					else:
                        			#print "Nothing Found!!";
						fo.write("\n[STEP_%.3d]\nDescription=%s\nStatus=Failed\n"%(steps,i))
                        			failing_count=failing_count+1;
                			count=count+1;
		print "***************************************************"
		print "******************Total Tests********************",count
		print "******************Total Pass Tests**************",passing_count
		print "******************Total Fail Tests***************",failing_count
		print "***************************************************"
		print "Note : Please check the Results.ini file for all tests results"
except SyntaxError:
        print "Raised by parser when syntax error is encountered"
except NameError:
        print "Raised when an identifier is not found in the local or global namespace"
except TypeError:
        print "Raised when a function or operation is applied to an object of incorrect type"
except IOError:
        print "Raised when an input/ output operation fails"
except IndexError:
        print "Raised when index of a sequence is out of range"
except AssertionError:
        print "Raised when Assert statement fails"
except  AttributeError:
        print "issue is due to testcase failures"

