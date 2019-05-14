import os
import sys
import re

if(len(sys.argv) == 1):
	print('The command line arguments are:[Help]-pass below testcases in command line')
	print "Please select any below tests and pass in command line";
	print "rlp_hip_test_Case_1";
	print "rlp_hip_test_Case_2";
	print "rlp_hip_test_Case_3";
	print "rlp_hip_test_Case_4";
	print "rlp_hip_test_Case_5";
	print "rlp_hip_test_Case_5";
	print "rlp_hip_test_Case_6";
	print "rlp_hip_test_Case_7";
	print "rlp_hip_test_Case_8";
	print "rlp_hip_test_Case_9";
	print "rlp_hip_test_Case_10";
	print "All_Tests";
#Build Steps for rocprofiler
#copy one testcase into home directory for profiling purpose

# Added by Paresh : Start
cwd=os.getcwd()
os.system("rm -rf Results.ini")
fo=open("Results.ini","a+")
steps=0

list=["rlp_hip_test_Case_1",
	"rlp_hip_test_Case_2",
	"rlp_hip_test_Case_3",
	"rlp_hip_test_Case_4",
	"rlp_hip_test_Case_5",
	"rlp_hip_test_Case_6",
	"rlp_hip_test_Case_7",
	"rlp_hip_test_Case_8",
	"rlp_hip_test_Case_9",
	"rlp_hip_test_Case_10"]

fo.write("[STEPS]\nNumber=%.3d\n"%(len(list)+1))

# Below checking if //hydinstreamcqe1/hsa is mounted or not
if not os.path.exists("/mnt/hsa/ROCm-TestApps"):
        if not os.path.exists("/mnt/hsa"):
                os.chdir("/mnt")
                os.system("sudo mkdir hsa")
                os.chdir("%s"%cwd)
        os.system("mount  -t cifs -o username=taccuser,password=AH64_uh1 //hydinstreamcqe1/hsa /mnt/hsa")

if not os.path.exists("/opt/rocm/rocprofiler/bin/rpl_run.sh"):
	os.system("sudo cp  /mnt/hsa/ROCm-TestApps/rocprofiler/rocprofiler_build.sh .")
        os.system("sudo sh rocprofiler_build.sh")

if not os.path.exists("%s/Desktop/rocprofiler"%os.getenv("HOME")):
        os.chdir("%s/Desktop"%os.getenv("HOME"))
        os.system("mkdir rocprofiler")
        os.chdir("%s"%cwd)

if os.path.exists("/opt/rocm/rocprofiler/bin/rpl_run.sh"):
        steps = steps + 1
        fo.write("\n[STEP_%.3d]\nDescription=rocprofiler build\nStatus=Passed\n"%steps)
else:
        steps = steps + 1
        fo.write("\n[STEP_%.3d]\nDescription=rocprofiler build\nStatus=Failed\n"%steps)

os.chdir("/opt/rocm/hip/samples/0_Intro/bit_extract")
os.system("sudo make")
os.chdir("%s"%cwd)

# Below checking if input.xls is available or not
if not os.path.exists("%s/Desktop/rocprofiler/input.xls"%os.getenv("HOME")):
        os.system("sudo cp -rf /mnt/hsa/ROCm-TestApps/rocprofiler/input.xml $HOME/Desktop/rocprofiler/.")

# Added by Paresh : End

i=1;
ext="log";
passing_count=0;
failing_count=0;
count=0;

commands = {"rlp_hip_test_Case_1":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i /home/taccuser/Desktop/rocprofiler/input.xml -o /home/taccuser/Desktop/rocprofiler/hip_be_out_1.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_2":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i /home/taccuser/Desktop/rocprofiler/input.xml -t /home/taccuser/Desktop/rocprofiler/tmp -o /home/taccuser/Desktop/rocprofiler/hip_be_out_2.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_3":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i /home/taccuser/Desktop/rocprofiler/input.xml -d /home/taccuser/Desktop/rocprofiler/rlp_hip_test_Case_3 -o /home/taccuser/Desktop/rocprofiler/hip_be_out_3.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_4":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp off -i /home/taccuser/Desktop/rocprofiler/input.xml -d /home/taccuser/Desktop/rocprofiler/tmp -o /home/taccuser/Desktop/rocprofiler/hip_be_out_4.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_5":'/opt/rocm/rocprofiler/bin/rpl_run.sh --basenames on -i /home/taccuser/Desktop/rocprofiler/input.xml -d /home/taccuser/Desktop/rocprofiler/rlp_hip_test_Case_5 -o /home/taccuser/Desktop/rocprofiler/hip_be_out_5.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_6":'/opt/rocm/rocprofiler/bin/rpl_run.sh --basenames off -i /home/taccuser/Desktop/rocprofiler/input.xml -d /home/taccuser/Desktop/rocprofiler/rlp_hip_test_Case_6 -o /home/taccuser/Desktop/rocprofiler/hip_be_out_6.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_7":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on --basenames on -i /home/taccuser/Desktop/rocprofiler/input.xml -d /home/taccuser/Desktop/rocprofiler/test_case_7 -o /home/taccuser/Desktop/rocprofiler/hip_be_out_7.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_8":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on --basenames off -i /home/taccuser/Desktop/rocprofiler/input.xml -d /home/taccuser/Desktop/rocprofiler/test_case_8 -o /home/taccuser/Desktop/rocprofiler/hip_be_out_8.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_9":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp off --basenames on -i /home/taccuser/Desktop/rocprofiler/input.xml -d /home/taccuser/Desktop/rocprofiler/test_case_9 -o /home/taccuser/Desktop/rocprofiler/hip_be_out_9.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract',
	"rlp_hip_test_Case_10":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp off --basenames off -i /home/taccuser/Desktop/rocprofiler/input.xml -d /home/taccuser/Desktop/rocprofiler/test_case_10 -o /home/taccuser/Desktop/rocprofiler/hip_be_out_10.csv /opt/rocm/hip/samples/0_Intro/bit_extract/bit_extract'}
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
		print "***************************************************";
		print "******************Total Tests********************",count;
		print "******************Total Pass Tests**************",passing_count;
		print "******************Total Fail Tests***************",failing_count;
		print "***************************************************";
		print "Note : Please check the Results.ini file for all tests results";
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

