import os
import sys
import re
os.system("rm -rf result.ini");
#print(type(sys.argv))
#print sys.argv[0];
if(sys.argv[0] == "command_line_based_automation.py"):
	print('The command line arguments are:[Help]-pass below testcases in command line')
	print "Please select any below tests and pass in command line";
	print "rlp_opencl_test_case_1";
	print "rlp_opencl_test_case_2";
	print "rlp_opencl_test_case_3";
	print "rlp_opencl_test_case_4";
	print "rlp_opencl_test_case_5";
	print "rlp_opencl_test_case_6";
	print "All_Tests";
list=["rlp_opencl_test_case_1","rlp_opencl_test_case_2","rlp_opencl_test_case_3","rlp_opencl_test_case_4","rlp_opencl_test_case_5","rlp_opencl_test_case_6"]
i=1;
ext="log";
passing_count=0;
failing_count=0;
count=0;
commands = {"rlp_opencl_test_case_1":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i /home/taccuser/SimpleConvolution/input.xml -o /home/taccuser/Desktop/rocprofiler/out1.csv /home/taccuser/SimpleConvolution/SimpleConvolution_fp16',"rlp_opencl_test_case_2":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i  /home/taccuser/SimpleConvolution/input.xml -t /home/taccuser/Desktop/rocprofiler/tmp -o /home/taccuser/Desktop/rocprofiler/out2.csv /home/taccuser/SimpleConvolution/SimpleConvolution_fp16',"rlp_opencl_test_case_3":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i /home/taccuser/SimpleConvolution/input.xml -d /home/taccuser/Desktop/rocprofiler/test_case_3 -o /home/taccuser/Desktop/rocprofiler/out3.csv /home/taccuser/SimpleConvolution/SimpleConvolution_fp16 ',"rlp_opencl_test_case_4":'/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on --basenames on -i /home/taccuser/SimpleConvolution/input.xml -d /home/taccuser/Desktop/rocprofiler/test_case_4 -o /home/taccuser/Desktop/rocprofiler/out4.csv /home/taccuser/SimpleConvolution/SimpleConvolution_fp16',"rlp_opencl_test_case_5":'/opt/rocm/rocprofiler/bin/rpl_run.sh --list-basic',"rlp_opencl_test_case_6":'/opt/rocm/rocprofiler/bin/rpl_run.sh --list-derived'}
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
					with open(f1) as open_file:
						data = open_file.read()
						searchObj = re.search("Fail|failed|Error|Failed*",data, re.M|re.I)
						if not searchObj:
                                        		#print "searchObj.group() : ", searchObj;
                                       			 fo=open("result.ini","a+");
                                        		 fo.write(k);
                                        		 fo.write(":");
                                        		 fo.write("Pass");
                                        		 fo.write("\n");
                                       			 passing_count=passing_count+1;
                                		else:
                                        		#print "Nothing Found!!";
							fo=open("result.ini","a+");
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
                        		searchObj = re.search("Fail|Error|Failed|fail*",data, re.M|re.I)
					if not searchObj:
                        			#print "searchObj.group() : ", searchObj;
                        			fo=open("result.ini","a+");
                        			fo.write(i);
                        			fo.write(":");
                        			fo.write("Pass");
                        			fo.write("\n");
                        			passing_count=passing_count+1;
					else:
                        			#print "Nothing Found!!";
						fo=open("result.ini","a+");
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

