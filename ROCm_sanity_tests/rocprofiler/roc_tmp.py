import os 
import sys
import re
#Build Steps for rocprofiler
command="sh rocprofiler_build.sh";
#os.system(command);
#copy one testcase into home directory for profiling purpose 
command1="mount -t cifs -o username=taccuser,password=AH64_uh1 //hydinstreamcqe1/hsa /mnt";
os.system(command1);
command2="sudo cp -rf /mnt/ROCm-TestApps/OpenCL/fp16_Lnx/SimpleConvolution/ /home/taccuser";
command3="sudo cp -rf /mnt/ROCm-TestApps/rocprofiler/input.xml /home/taccuser/SimpleConvolution/";
#os.system(command2);
#os.system(command3);
command4="umount /mnt";
#os.system(command4);
applications=["SimpleConvolution"];
testcase_names=["Test_case1","Test_case2","Test_case3","Test_case4","Test_case5","Test_case6"];
test_commands=["/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i","/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i","/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on -i","/opt/rocm/rocprofiler/bin/rpl_run.sh --timestamp on --basenames on -i","/opt/rocm/rocprofiler/bin/rpl_run.sh --list-basic"," /opt/rocm/rocprofiler/bin/rpl_run.sh --list-derived"]
xml_file_loc="/home/taccuser/SimpleConvolution/input.xml";
output_file="/home/taccuser/Desktop/rocprofiler/out.csv -o";
test_loc="/home/taccuser/SimpleConvolution/SimpleConvolution_fp16";
ext="log";
l=len(test_commands);
passing_count=0;
failing_count=0;
count=0;
for k in test_commands:
	for i in testcase_names:
		exe="%s %s %s %s >%s.%s"%(k,xml_file_loc,output_file,test_loc,i,ext)
		print exe;
		os.system(exe);
		f1="%s.%s"%(i,ext)
		with open(f1) as open_file:
                        data = open_file.read()
                        searchObj = re.search("[\w\.]+-[\w\.]+-[\w\.]|[0-255]|[0-255]|\d",data, re.M|re.I)
                if searchObj:
                        print "searchObj.group() : ", searchObj;
                        fo=open("result.ini","a+");
                        fo.write(f1);
                        fo.write(":");
                        fo.write("Pass");
                        fo.write("\n");
                        passing_count=passing_count+1;
                else:
                        print "Nothing found!!"
                        fo.write(f1);
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

	
		
