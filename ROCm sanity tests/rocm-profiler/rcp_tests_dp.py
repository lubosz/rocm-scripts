## Created by    : Paresh Patel
## Creation Date : 04/12/2018
## Description   : Script is for Testing OpenCL and Hip profiling with rocm-profiler(RCP)

import os
import sys
import re
os.system("rm -rf result.ini");
os.system("rm -f rcp_opencl_test_case*")
os.system("rm -f rcp_hip_test_case*")
cwd=os.getcwd()
os.chdir("%s/Desktop/RCP"%os.getenv("HOME"))
os.system("rm -f rcp_opencl_test_case*")
os.system("rm -f rcp_hip_test_case*")
os.chdir("%s"%cwd)

if(sys.argv[0] == "command_line_based_automation.py"):
        print('The command line arguments are:[Help]-pass below testcases in command line')
        print "Please select any below tests and pass in command line"
        print "rcp_opencl_test_case_1"
        print "rcp_opencl_test_case_2"
        print "rcp_opencl_test_case_3"
        print "rcp_opencl_test_case_4"
        print "rcp_hip_test_case_1"
        print "rcp_hip_test_case_2"
        print "All_Tests"
list=["rcp_opencl_test_case_1",
	"rcp_opencl_test_case_2",
	"rcp_opencl_test_case_3",
	"rcp_opencl_test_case_4",
	"rcp_hip_test_case_1",
	"rcp_hip_test_case_2"]
i=1;
ext="log";
passing_count=0;
failing_count=0;
count=0;
# Below checking if OpenCL app is available or not
if not os.path.exists("$HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16"):
	if not os.path.exists("/mnt/ROCm-TestApps"):
		os.system("mount  -t cifs -o username=taccuser,password=AH64_uh1 //hydinstreamcqe1/hsa /mnt")
	os.system("sudo cp -rf /mnt/ROCm-TestApps/OpenCL/fp16_Lnx/SimpleConvolution $HOME/Desktop/RCP/.")

# Below checking if OpenCL app is available or not
if not os.path.exists("/opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose"):
	cwd=os.getcwd()
	os.chdir("/opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose")
	os.system("sudo make")
	os.chdir("%s"%cwd)

commands = {"rcp_opencl_test_case_1":'/home/taccuser/Desktop/RCP/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_1.atp -t -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_2":'/home/taccuser/Desktop/RCP/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_2.csv -p -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_3":'/home/taccuser/Desktop/RCP/bin/rcprof -o $HOME/Desktop/RCP/rcp_opencl_test_case_3.atp -t -T -w $HOME/Desktop/RCP/SimpleConvolution/ $HOME/Desktop/RCP/SimpleConvolution/SimpleConvolution_fp16 --device gpu',
	"rcp_opencl_test_case_4":'/home/taccuser/Desktop/RCP/bin/rcprof -a ~/Desktop/RCP/rcp_opencl_test_case_1.atp -T',
	"rcp_hip_test_case_1":'/home/taccuser/Desktop/RCP/bin/rcprof -o $HOME/Desktop/RCP/rcp_hip_test_case_1.csv -C -w /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose',
	"rcp_hip_test_case_2":'/home/taccuser/Desktop/RCP/bin/rcprof -o $HOME/Desktop/RCP/rcp_hip_test_case_2.atp -A -w /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose /opt/rocm/hip/samples/2_Cookbook/0_MatrixTranspose/MatrixTranspose'}
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
					#print ("%s"%f1)
					with open(f1) as open_file:
						data = open_file.read()
						searchObj = re.search("Failed *",data, re.M|re.I)
                                       		fo=open("result.ini","a+");
						if not searchObj:
                                        		#print "searchObj.group() : ", searchObj;
                                        		 fo.write(k);
                                        		 fo.write(":");
                                        		 fo.write("Pass");
                                        		 fo.write("\n");
                                       			 passing_count=passing_count+1;
                                		else:
                                        		#print "Nothing Found!!";
                                        		fo.write(k);
                                        		fo.write(":");
                                        		fo.write("Fail");
                                        		fo.write("\t");
                                        		fo.write("\n");
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
				with open(f1) as open_file:
                        		data = open_file.read()
                        		searchObj = re.search("[\w\.]+-[\w\.]+-[\w\.]|[0-255]|[0-255]|\d",data, re.M|re.I)
					if searchObj:
                        			#print "searchObj.group() : ", searchObj;
                        			fo=open("result.ini","a+");
                        			fo.write(i);
                        			fo.write(":");
                        			fo.write("Pass");
                        			fo.write("\n");
                        			passing_count=passing_count+1;
					else:
                        			#print "Nothing Found!!";
                        			fo.write(i);
                        			fo.write(":");
                        			fo.write("Fail");
                        			fo.write("\t");
                        			fo.write("\n");
                        			failing_count=failing_count+1;
                			count=count+1;
		print "***************************************************";
		print "******************Total Tests********************",count;
		print "******************Total Pass Tests**************",passing_count;
		print "******************Total Fail Tests***************",failing_count;
		print "***************************************************";
		print "Note : Please check the result.ini file for all tests results";
except SyntaxError:
        print "Raised by parser when syntax error is encountered";
except NameError:
        print "Raised when an identifier is not found in the local or global namespace";
except TypeError:
        print "Raised when a function or operation is applied to an object of incorrect type";
except IOError:
        print "Raised when an input/ output operation fails";
except IndexError:
        print "Raised when index of a sequence is out of range";
except AssertionError:
        print "Raised when Assert statement fails";
except  AttributeError:
        print "issue is due to testcase failures";

