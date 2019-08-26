import os
import sys
import re

if(len(sys.argv) == 1):
	print('The command line arguments are:[Help]-pass below testcases in command line')
	print "Please select any below tests and pass in command line";
	print "rocm-smi-vbios-ver";
	print "rocm-smi-gpu-id";
	print "rocm-smi-fan-level";
	print "rocm-smi-pwr-level";
	print "rocm-smi-pwrplay-level";
	print "rocm-smi-clk-level";
	print "rocm-smi-temp";
	print "rocm-smi-first-clk-level";
	print "rocm-smi-reset-clocks";
	print "rocm-smi-set-gpu-clock";
	print "rocm-smi-set-gpu-clock-boundary-cond";
	print "rocm-smi-set-mem-clock";
	print "rocm-smi-set-mem-clock-boundary-cond";
	print "rocm-smi-reset-fan";
	print "rocm-smi-set-fan";
	print "rocm-smi-mem-ovrdrv-level";
	print "rocm-smi-show-profiles";
	print "All_Tests";

cwd=os.getcwd()
os.system("rm -rf Results.ini");
fo=open("Results.ini","a+");
steps=0

list=["rocm-smi-vbios-ver",
	"rocm-smi-gpu-id",
	"rocm-smi-fan-level",
	"rocm-smi-pwr-level",
	"rocm-smi-pwrplay-level",
	"rocm-smi-clk-level",
	"rocm-smi-temp",
	"rocm-smi-first-clk-level",
	"rocm-smi-reset-clocks",
	"rocm-smi-set-gpu-clock",
	"rocm-smi-set-gpu-clock-boundary-cond",
	"rocm-smi-set-mem-clock",
	"rocm-smi-set-mem-clock-boundary-cond",
	"rocm-smi-reset-fan",
	"rocm-smi-set-fan",
	"rocm-smi-mem-ovrdrv-level",
	"rocm-smi-show-profiles"]

fo.write("[STEPS]\nNumber=%.3d\n"%(len(list)+1))

#if rocm-smi is not present then install it
if not os.path.exists("/opt/rocm/bin/rocm-smi"):
	if os.path.exists("%s/Desktop/package"%os.getenv("HOME")):
                os.chdir("%s/Desktop/package/deb/rocm-smi"%os.getenv("HOME"))
                os.system("sudo dpkg -i *.deb")
		os.chdir("%s"%cwd)
	else:
        	os.system("sudo apt-get install rocm-smi")

if not os.path.exists("/opt/rocm/bin/rocm-smi"):
	steps = steps + 1
	fo.write("\n[STEP_%.3d]\nDescription=rocm-smi build\nStatus=Failed\n"%steps)
else:
	steps = steps + 1
	fo.write("\n[STEP_%.3d]\nDescription=rocm-smi build\nStatus=Passed\n"%steps)


i=1;
ext="log";
passing_count=0;
failing_count=0;
count=0;
commands = {"rocm-smi-vbios-ver" : '/opt/rocm/bin/rocm-smi --showvbios',
	"rocm-smi-gpu-id" : '/opt/rocm/bin/rocm-smi --showid',
	"rocm-smi-fan-level":'/opt/rocm/bin/rocm-smi -f',
	"rocm-smi-pwr-level":'/opt/rocm/bin/rocm-smi -P',
	"rocm-smi-pwrplay-level":'/opt/rocm/bin/rocm-smi -p',
	"rocm-smi-clk-level":'/opt/rocm/bin/rocm-smi -c',
	"rocm-smi-temp":'/opt/rocm/bin/rocm-smi -t',
	"rocm-smi-first-clk-level":'/opt/rocm/bin/rocm-smi -g',
	"rocm-smi-reset-clocks":'/opt/rocm/bin/rocm-smi -r',
	"rocm-smi-set-gpu-clock":'/opt/rocm/bin/rocm-smi --setsclk 3 5 ',
	"rocm-smi-set-gpu-clock-boundary-cond":'/opt/rocm/bin/rocm-smi --setsclk 7 ',
	"rocm-smi-set-mem-clock":'/opt/rocm/bin/rocm-smi --setmclk 1 3 ',
	"rocm-smi-set-mem-clock-boundary-cond":'/opt/rocm/bin/rocm-smi --setmclk 7 ',
	"rocm-smi-reset-fan":'/opt/rocm/bin/rocm-smi --resetfans',
	"rocm-smi-set-fan":'/opt/rocm/bin/rocm-smi --setfan 30 ',
	"rocm-smi-mem-ovrdrv-level":'/opt/rocm/bin/rocm-smi -m',
	"rocm-smi-show-profiles":'/opt/rocm/bin/rocm-smi -l'}
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
						searchObj = re.search("[\w\.]+-[\w\.]+-[\w\.]|[0-255]|[0-255]|\d|high|auto|manual|low",data, re.M|re.I)
						if searchObj:
                                        		#print "searchObj.group() : ", searchObj;
							fo.write("\n[STEP_%.3d]\nDescription=%s\nStatus=Passed\n"%(steps,k))
                                       			passing_count=passing_count+1;
							os.system("rm %s"%command1)
                                		else:
                                        		#print "Nothing Found!!";
							fo.write("\n[STEP_%.3d]\nDescription=%s\nStatus=Failed\n"%(steps,k))
                                        		failing_count=failing_count+1;
                                		count=count+1;
			break;
				
		else:
			j=j+1;
        		if(j>=1):
	        		i=i.rstrip('\r\n');
				command="%s>%s.%s"%(commands[i],i,ext)
				print command;
				command1="%s.%s"%(i,ext);
				f1=command1.strip("\n");
				steps = steps + 1
				with open(f1) as open_file:
                        		data = open_file.read()
                        		searchObj = re.search("[\w\.]+-[\w\.]+-[\w\.]|[0-255]|[0-255]|\d|high|auto|manual|low",data, re.M|re.I)
				
                			if searchObj:
                        			#print "searchObj.group() : ", searchObj;
						fo.write("\n[STEP_%.3d]\nDescription=%s\nStatus=Passed\n"%(steps,i))
                        			passing_count=passing_count+1;
						os.system("rm %s"%command1)
					else:
                        			#print "Nothing Found!!";
						fo.write("\n[STEP_%.3d]\nDescription=%s\nStatus=Failed\n"%(steps,i))
                        			failing_count=failing_count+1;
                			count=count+1;
	print "***************************************************";
	print "******************Total Tests********************",count;
	print "******************Total Passed Tests**************",passing_count;
	print "******************Total Failed Tests***************",failing_count;
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

