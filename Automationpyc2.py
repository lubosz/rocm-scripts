# -*- coding: utf-8 -*-
'''
Description:
    1) pulling and launching caffe2/pytorch docker Image
    2)Run the test.sh
    3)redirecting logs
    4)parsing logs
    5)Drawing prettytable
'''
import os
import time
import re
import sys
import shutil
if len(sys.argv)!=3:
    print ("\nGive Proper Input")
    print ("\npyc2prettytable.py  < Testname> <DokerImange>\n")
    print ("Example: pyc2prettytable.py pytorch rocmqa/pyc2-10327-py2:ub16.04\n\n")
    exit()

import subprocess as sub
k=os.system('echo AH64_uh1 | sudo -S pip install prettytable')#,shell=True)

from prettytable import PrettyTable
pt=PrettyTable()  # Creating instance for pretty table
pt2=PrettyTable()
#k=sub.call('echo AH64_uh1 | sudo pip install prettytable',shell=True)
def Caffe2Test(Dokerimage):
    TestList=[] # Store test case list
    PassList=[] # Store Pass test cases
    FailedList=[] # Store failed Test
    NofTests=[] # Store no of Test in Testcase
    TestList1=[]
    PassList1=[]
    FailedList1=[]
    NofTests1=[]
    CppTest=0 # Test case flags
    PythonTest=0
    logpath=os.path.expanduser('~/dockerx')
    logpath=logpath+'/Caffe2Logs'
    if os.path.isdir(logpath):
        shutil.rmtree(logpath)
    os.mkdir(logpath,0777)
    
    try:
        Path=r'/root/caffe2/.jenkins/caffe2/test.sh -v'
        Command=sub.call("sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee %s/c2logprint.log"%(Dokerimage,Path,logpath),shell=True)
       
        #k=os.system('echo AH64_uh1 | sudo chmod 777 c2logprint.log')
    except :
        print("Not done perfectly")
    
    pt.field_names=['Testcase Names','No of test','Failed','Passed']
    pt.align='l'
    pt2.field_names=['Testcase Names','No of test','Failed','Passed']
    pt2.align='l'
    p2=re.compile(r'(\d+) tests? from ([A-Za-z_]+\/?\w*)') # Search for no of testcases from test case 
    p1=re.compile(r'(\d+) tests? from (\w+\/?\d?)(\,)')  # search for test cases ends with ,
    p4=re.compile(r'(\d+) tests? from (\w+\/?\w*) \(\d+ ms total\)') # Search for no test cases ran
    path=logpath+r"/c2logprint.log"
    try:
        with open(path,'r')as Fi:  
            i=Fi.readline()
            while i:
                if "r(core dumped)" in i:
                    print "Core dump Exception Occured\n "
                if "Running C++ tests" in i: # enabling flags according to testcase c++/python
                    CppTest=1
                    PythonTest=0
                if "Running Python tests" in i:
                    CppTest=0
                    PythonTest=1
                s2=re.search(p2,i) #Search for Testcase name
                s1=re.search(p1,i) # Search for Testcase name ends with coma

                if s2:
                    if CppTest==1:
                        i=Fi.readline() # read the next line 
                        TestList.append(s2.group(2)) # getting testcase name     Ex: 4 tests from UtilsBoxesTest/1.  
                        passcount=0 # counting no of test  passsed in a Testcase
                        while i: # loop will continue until Testcase result came  #  4 tests from UtilsBoxesTest (0 ms total)
                         
                            test=s2.group(2)                
                            s3=re.search(r'\[       OK \]',i)               # it it found the test is passed
                        
                            if s3:
                                passcount=passcount+1                    
                            else:                  
                                s4=re.search(p4,i) # Searching for endline if it came stop the test case  EX:  4 tests from UtilsBoxesTest (0 ms total)
                                if s4 :
                                     break
                            i=Fi.readline()
                        PassList.append(passcount) #represent no of test passes in single testcase
                        failed=int(s2.group(1))-passcount # Calculating failed test cases
                        NofTests.append(s2.group(1)) # No of test in Testcase
                        FailedList.append(failed)
                        
                    
                i=Fi.readline()
                    
        totalpass=0
        totalfailed=0
        totaltests=0

        for i in range(len(TestList)):  # Fillng stored data for prettytable.
            pt.add_row([TestList[i],NofTests[i],FailedList[i],PassList[i]])
            totalpass=totalpass+int(PassList[i])
            totalfailed=totalfailed+int(FailedList[i])
            totaltests=totaltests+int(NofTests[i])
 
        pt1=PrettyTable()
        
        print("\nC++ testcases\n")
        pt1.field_names=[" ",'Total Testcases','Total Test', 'Total Failed','Total Pass']
        pt1.add_row([" Summery ",len(TestList),totaltests,totalfailed,totalpass])
        print pt
	print"C++ Testcase Summary\n"
        print pt1
	######################################## python testcases start hee
	Tst=[]
	LstTst=[0,0,0,0]
	Testname=[]
	AtlTstname=""
	flage=0
	TotTst=[]
	first=0
	passcount=0
	failedcount=0
	skippedcount=0
	Totpass=0
	Totfail=0
	Totskipped=0
	count=0
	k=os.system(r"cat %s/c2logprint.log | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | col -b > %s/C2logprint.log"%(logpath,logpath))
	with open(logpath+r'/C2logprint.log','r') as f:
		Line=f.readline()
		while Line:
			p1=re.search(r'(\:\:)(\w+)(\.\w+)', Line)                
			if p1:
				if p1.group(2) in Testname:               
					Pass=re.search(r'(\:\:)(%s)(\.\w+)'%(p1.group(2)),Line)
						
					if Pass:
						if re.search('(✓)',Line):
							passcount=passcount+1
							Totpass=Totpass+1
					skipped=re.search(r'(\:\:)(%s)(\.\w+)( s)'%(p1.group(2)),Line)
					if skipped:
						if re.search(r'\bs',Line):
							skippedcount=skippedcount+1		
							Totskipped=Totskipped+1
					failed=re.search(r'(\:\:)(%s)(\.\w+)'%(p1.group(2)),Line)
					if failed:
						if re.search(r'( ⨯)',Line):
							failedcount=failedcount+1
							Totfail=Totfail+1
					if flage==0:
						AtlTstname=p1.group(2)
					LstTst[0]=p1.group(2)
					LstTst[1]=passcount
					LstTst[2]=skippedcount
					LstTst[3]=failedcount
					flage=1
				else:				
					Testname=p1.group(2)
					flage=0		
					if flage==0 and first==1:	
						Tst.append(AtlTstname)
						Tst.append(passcount)
						Tst.append(skippedcount)
						Tst.append(failedcount)
						TotTst.append(Tst)
					
						passcount=0
						failedcount=0
						skippedcount=0
						Tst=[]
				
			else:	
				Line=f.readline()
				p1=re.search(r'(\:\:\w+)(\.\w+)',Line)
				if p1:
					flage=0
					
			if flage!=0:
				Line=f.readline()
				flage=1
				first=1
			
	TotTst.append(LstTst)
	ptpy=PrettyTable()
	ptpy.field_names=['Testname','Passs','skipped','failures']
	for i in TotTst:
		ptpy.add_row(i)
	ptpy.align='l'
	ptpy2=PrettyTable()
	ptpy2.field_names=[" ","TotalTestcases","Passed","Skipped","Failed"]
	ptpy2.add_row(["Test Summary",len(TotTst),Totpass,Totskipped,Totfail])
	print "Python Testcases"
	print ptpy
	print "Python Test Summaery"
	print ptpy2
        

        
	with open(logpath+r'/C2Tablesummery.txt','wb') as T: # Storing for future use.
		T.write("C++ Testcases\n")
		T.write(pt.get_string())
		T.write('\n\n')
		T.write("C++ Test Summary\n")
		T.write(pt1.get_string())
		T.write("\n\nPython Testcases\n")
		T.write(ptpy.get_string())
		T.write("\n")
		T.write("Python Test Summary\n")
		T.write(ptpy2.get_string())
            
     
    except KeyboardInterrupt:
	print("Keyboard Inttrepution")
    except IOError:
        print("Raised when an input/ output operation fails, such as the print statement or the open()")

###########################################################################################################  
def PytorchTest(Dokerimage):
    #os.environ['PYTORCH_TEST_WITH_ROCM']='1'
    logpath='~/dockerx'
    logpath=os.path.expanduser(logpath)
    logpath=logpath+'/PytorchLogs'
    if os.path.isdir(logpath):
        shutil.rmtree(logpath)
    os.mkdir(logpath,0777)
    
    Path=r'cat /root/pytorch/test/run_test.py'
    Command=sub.call("sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee  run_test.txt exit"%(Dokerimage,Path),shell=True)
    print "Exited from docker"
    
    with open('run_test.txt','r') as f:
        testcases=[]
        block=[]
        i=f.readline()
        while i:
            if re.search(r'TESTS = \[',i):
                i=f.readline()
                while i:
                    if re.search(r'\]',i):
                        break
                    i=i.strip()
                    i=i.strip(" ',")
                    testcases.extend([i])
        
                    i=f.readline()
            if re.search(r'ROCM_BLACKLIST = \[',i):
                i=f.readline()
                
                while i:
                    if re.search(r'\]',i):
                        break
                    i=i.strip()
                    i=i.strip(" ',")
                    block.extend([i])
                    i=f.readline()
            i=f.readline()
        print testcases
        print block
        #testcases=(set(testcases))
        #block=(set(block))
        #testcases.difference_update(block)
        #Tests=sorted(list(testcases))
	for i in block:
            if i in testcases:
                testcases.remove(i)	
        Tests=testcases
        ActualTest=' '.join(testcases)
        Loopcount=0 #Loopcount for counting iterations
    Slice="" #Slice store's last ran test name
    while True:
            
        pt=PrettyTable() #create instance of prettytable
        try:
            if Loopcount==0: # Start test case here 
                #if os.path.isfile(r'/home/pytorch/test/run_test.py'):
                #    print "Path"
                Path=r'python /root/pytorch/test/run_test.py -v' 
                    
            else: #enter if it is seconf iteration
		#print Slice
                if len(Slice)!=0: #checking slice is free or not

                    Index=re.search(r'\b%s\b'%(Slice),ActualTest).start() #get the index of Slice in Actural test
                    Index=Index+len(Slice)+1 # I point to the next test name to run
		    print ActualTest[Index:] 
                    Path=r'python /root/pytorch/test/run_test.py -v -i %s'%(ActualTest[Index:]) #Run the test with this command
            
            print"Before Lauching Docker"
            Command=sub.call(r"sudo docker run --env PYTORCH_TEST_WITH_ROCM='1' -it --network=host --device=/dev/kfd --device=/dev/dri --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee  %s/pylog.log"%(Dokerimage,Path,logpath),shell=True) #Pulling and Launching running unitest
            os.system("echo AH64_uh1 | sudo -S chmod 777 %s/psylog.log"%(logpath))         #pylog store logs until runing test eith out fail
        except IndexError:
            break
            print("Raised when an index is not found in a sequence.")
        except KeyboardInterrupt:
            break
            print ("aised when the user interrupts program execution")
        except IOError:
            print("Raised when an input/ output operation fails, such as the print statement or the open()")
        try:
            time.sleep(5)
           
            pt.field_names = ['TestName','Total','failures',"errors",'Skipped', 'Expected failures','Pass']# Colomn name of prettytable
            pt.align='l' # Left side alignment
            TestName=[] #List to store Testcase names
            RunTests=[] #List to store tests 
            Result=[] #List to strre how many pass failed skiiped in string formate
            Path=logpath+r"/pylog.log" 
            
            Running=re.compile(r'(Running) (test_\w+) (\.\.\. \[\d+)') #This is for searching test name 
            Status=re.compile(r'^OK') #Checking test pass case
            Status2=re.compile(r'^FAILED') #checking test fail case
            Nooftest=re.compile(r'(Ran) (\d+) (test)') # searching for Pass failed pattern
            L1=0 #flags
            L2=0
            #Slice=""
            with open(Path,'r',) as Fi:
                
                for i in Fi: #Reading single line at a time
                    #print i
                    Name=re.search(Running,i) # searching for testcase name
                    testrun=re.search(Nooftest,i) # search for total tests
                    result=re.findall(Status,i) # search for pass
                    result1=re.search(Status2,i) # search for fail
                    if(Name and L1==0 and L2==0):            
                        TestName.append(Name.group(2))                       
                        L1=1  
                        Slice= Name.group(2)
                        Slice=Slice.replace("test_",'') # getting corrent running testcase name for future use
                    elif(Name and L1 and L2==0):
                        with open('Testcase.txt','a') as f:
                            f.write(Slice+r',0,0,0,0,0,0')
                            f.write('\n')
                        TestName.pop()
                        TestName.append(Name.group(2))                       
                        L1=1  
                        Slice= Name.group(2)
                        Slice=Slice.replace("test_",'') # getting corrent running testcase name for future use
		 
                    elif(testrun and L1 and L2==0):            
                        RunTests.append(testrun.group(2))
                        L2=1
                    #elif()
                    elif((result or result1) and L1 and L2):
                    
                        Result.append(i.rstrip())
                        L1=0
                        L2=0
                
                    else:
                        pass
                Result1=[]
                #print Result
                
                for i in Result: # In a result failure and expected failure are there to remove conflict chnage expected failure with ExpFailures
                    i=i.replace('expected failures',"ExpFailures")#expecte dfailures
                    Result1.append(i)       
                count1=0
                if len(Result1)==0: #if test executed with out result (Not pass fail) adding manually pass fail for future use
                    with open("Testcase.txt",'a')as f:
                        #print "Resulr==0"
                        f.write(Slice+r',0,0,0,0,0,0') # 
                        f.write('\n')
                Result=[]
                                            
                String=""
                for i in Result1:
                    
                    i=i.replace('(',',')
                    i=i.replace(")",'')
       
                    
                    String="%s "%(RunTests[count1]) # adding No of test
                    k=re.search(r'(failures=\d+)',i) # All test cases dont have all fields below so we are adding manually.
                    if k:
                        String=String+k.group()+" "
                    else:
                        String=String+'failures=0 ' # if no falure add failure =0 for proper alignment.

                    k=re.search('(errors=\d+)',i)
                    if k:
                        String=String+k.group()+" "
                    else:
                        String=String+'errors=0 ' #if no falure add errors =0 for proper alignment.

                    k=re.search(r'skipped=\d+',i)
                    if k:
                        String=String+k.group()+" "
                    else:
                        String=String+'skipped=0 ' #if no falure add skipped =0 for proper alignment.

                    k=re.search(r'(ExpFailures=\d+)',i)
                    if k:
                        String=String+k.group()+" "
                    else:
                        String=String+'ExpFailures=0 ' #if no falure add ExpFalure=0 for proper alignment.
                
                    if 'pass' not in i:
                        
                        List=re.findall(r'\d+',String)
                        if List:
                            
                            Pass=(int(List[0])-int(List[1])-int(List[2])-int(List[3])-int(List[4])) 
                            String= String+' pass=%s'%(str(Pass)) # calculating not test passed and adding to string
                    if "OK" in i:
                        String='%s '%(TestName[count1])+String # Adding test name
                    else:
                        String='%s '%(TestName[count1])+String
                    count1=count1+1
                    Result.append(String)
                
                count2=0
                print('Test Case Summary')
                for i in Result:
                    List=re.findall(r'=\d+',i)

                    List.insert(0,TestName[count2])          
                    List.insert(1,RunTests[count2]) # writing Test name, total test fail,error skiiped expderrors,pass for print prettytable 
                    with open('Testcase.txt','a') as f:
                        f.write(List[0]+","+List[1]+","+List[2][1:]+","+List[3][1:]+","+List[4][1:]+","+List[5][1:]+","+List[6][1:])
                        f.write('\n')
                    count2=count2+1            

        except KeyboardInterrupt:
            break
            print ("aised when the user interrupts program execution")
        except IOError:
           print("Raised when an input/ output operation fails, such as the print statement or the open()")

        TotalTestcases=0 # to print testcase summary counting tecases results
        Totalskipped=0
        TotalExpFail=0
        Totalfailed=0
        Totalpass=0
        Totalerrors=0
        pt.field_names = ['TestName','Total','Failures',"Errors",'Skipped', 'Expected failures','Pass']
        with open('Testcase.txt','r') as f: # reading formated data and printing pretty table
            T=[]
            for i in f:        
                i=i.replace('\n','')
                k=list(i.split(","))
                T.append(i[0])
                pt.add_row([k[0],k[1],k[2],k[3],k[4],k[5],k[6]])
                TotalTestcases=TotalTestcases+int(k[1])
                Totalfailed=Totalfailed+int(k[2])
                Totalerrors=Totalerrors+int(k[3])
                Totalskipped=Totalskipped+int(k[4])
                TotalExpFail=TotalExpFail+int(k[5])
                Totalpass=Totalpass+int(k[6])

        pt1=PrettyTable()
        pt.algn='l'
        pt1.field_names = [" ","Tottal Testcase's",'Total','Failures',"Errors",'Skipped', 'Expected failures','Pass']
        pt1.add_row(["Total Summary",len(T),TotalTestcases,Totalfailed,Totalerrors,Totalskipped,TotalExpFail,Totalpass])
        print"Pytorch Testcase's."
        print pt
        print "Pytorch Testcase summary\n"
        print pt1
        with open(logpath+r'/SummerytablePytorch.txt','wb')as f: # Storing pretty table for future use
            f.write("Pytorch Testcase Summery Table\n")
            f.write(pt.get_string())
            f.write('\n')
            f.write("Pytorch Test Summary\n")
            f.write(pt1.get_string())
            f.write('\n')	

        if Tests[-1] in Slice:
	    break

        else: # if tstcases failed it will skip the failed and continue next test using Slice and Loopcount 
            os.system(r'cat %s/pylog.log >> %s/pylogprint.log'%s(logpath,logpath))
            print Slice
        Loopcount=Loopcount+1
        


################################################################################################
if __name__=='__main__':
    print sys.argv
    docker=sub.call('echo AH64_uh1 | sudo -S docker ps -a | grep %s'%(sys.argv[2]),shell= True,stdout=sub.PIPE)
    
    if docker ==0:
        print"\n Launching the docker image %s\n\n"%(sys.argv[2])
    else:
        print "\n Pulling the docker image %s\n\n"%(sys.argv[2])
    if sys.argv[1]not in ['pytorch','caffe2']:
        print"Please give  correct testname\n\n pytorch (or) caffe2\n\n "
        exit()
    exist=os.path.isfile('fail.txt')
    if exist:
        os.remove("fail.txt")
    if os.path.isfile("Testcase.txt"):    
        os.remove('Testcase.txt')
    if os.path.isfile("pylogprint.log"):    
        os.remove('pylogprint.log')

    if "pytorch" in sys.argv[1]:
        PytorchTest(sys.argv[2])
    elif "caffe2" in sys.argv[1]:
        Caffe2Test(sys.argv[2])
