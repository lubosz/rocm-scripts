## -*- coding: utf-8 -*-
'''
Description:
    1) pulling and launching caffe2/pytorch docker Image
    2)Run the test.sh
    3)redirecting logs
    4)parsing logs
    5)Drawing prettytable
'''
#import future
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
#import ROCm_Api3 as rocapi
import os
import re
from datetime import datetime
import sys
import  multiprocessing as mps
k=os.system('echo AH64_uh1 | sudo pip3 install prettytable')  #
#k=os.system('echo AH64_uh1 | sudo pip3 install artifactory')
#from artifactory import ArtifactoryPath
from prettytable import PrettyTable
import subprocess as sub

ActualTest_name=""

run_parallel_flag=0
rocm = ""
HTML = '''
<html>
<head>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
  text-align: left;
}
</style>
</head>
'''
mail_path = ""
filename = 'pyc2_ut_'
logfile = ""
summaryfile= ""
'''logpath = os.path.expanduser('~/')
logpath = logpath + '/dockerx'''
'''print (logpath)
if os.path.isdir(logpath):
    os.system('echo AH64_uh1 | sudo chmod 777 %s' % logpath)
else:
    os.mkdir(logpath)
    os.system('echo AH64_uh1 | sudo chmod 777 %s' % logpath)'''



###################################################################

def Caffe2Test(logpath,logfile):
    '''
    This function launch the docker,run the caffe2 unit test and generate the pretty table summary file,log files.

    :param dockerimage: it is a docker image name
    :param roc_ptable: it is rocmaster version prettytable object get from pre_requisites function.
    :param gpu: is useful  in multi gpu machine on which caffe2 test need to run
    :return: it success it return 0
    '''
    '''print(ActualTest_name)
    if 'pyc2' in ActualTest_name:
        if '+' in dockerimage:
            dockerimage=dockerimage.split('+')
            Dockerimage=dockerimage[1]
        else:
            print("Please provide pytoch docker image fallowed by '+'(No Space) fallowed by caffe2 dockerimage\nExample: computecqe/pytorch:rocm24-RC3-25-ub1604+computecqe/caffe2:rocm24-RC3-25-ub1604")
            exit()
    else:
        Dockerimage=dockerimage

    print ("GPU name : %s"%str(gpu))
    print ("DockerImage name %s: "%Dockerimage)
    global mail_path'''
    #global logpath
    global summaryfile
    global test_name
    #logfile= filename +'caffe2'+ '_log.log'
    summaryfile = filename + "caffe2" + '_summary.txt'
    start=datetime.now()
    pt1 = PrettyTable()
    pt = PrettyTable()  # Creating instance for pretty table
    totalpass = 0
    totalfailed = 0
    totaltests = 0
    TestList = []  # Store test case list
    PassList = []  # Store Pass test cases
    FailedList = []  # Store failed Test
    NofTests = []  # Store no of Test in Testcase
    Tst = []
    LstTst = ["",0, 0, 0, 0]
    Testname = []
    AtlTstname = ""
    flage = 0
    TotTst = []
    first = 0
    passcount = 0
    failedcount = 0
    skippedcount = 0
    Totpass = 0
    Totfail = 0
    Totskipped = 0

    #logpath =logpath
    #logpath = logpath + '/Caffe2Logs'
    '''if os.path.isdir(logpath):
        os.system('echo AH64_uh1 | sudo rm -rf %s' % logpath)
    os.mkdir(logpath,0o777)'''
    mail_path = logpath
    #with open(logpath + '/c2logprint.log', 'w') as writefile:
        #writefile.write(roc_ptable.get_string())
    '''try:
        Path = r'/root/caffe2/.jenkins/caffe2/test.sh -v'
        if run_parallel_flag==0:
            Command = sub.call("echo AH64_uh1 | sudo docker run -i --rm --network=host --device=/dev/kfd --device=/dev/dri --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee -a %s/c2logprint.log" % (Dockerimage, Path, logpath), shell=True)
        else:
            Command = sub.call("echo AH64_uh1 | sudo docker run -i --rm --network=host --device=/dev/kfd --device=/dev/dri/%s --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee -a %s/c2logprint.log" % (gpu,Dockerimage, Path, logpath), shell=True)
    #except IOError:
    #    pass
    except KeyboardInterrupt:
        
        print("Docker Aborted\n")
        pass'''
    runtime=datetime.now()-start
    test_name="caffe2"
    pt.field_names = ['Testcase Names', 'No of test','Passed' ,'Failed']
    pt.align = 'l'
    p2 = re.compile(r'(\d+) tests? from ([A-Za-z_]+\/?\w*)')  # Search for no of testcases from test case
    p1 = re.compile(r'(\d+) tests? from (\w+\/?\d?)(\,)')  # search for test cases ends with ,
    p4 = re.compile(r'(\d+) tests? from (\w+\/?\w*) \(\d+ ms total\)')  # Search for no test cases ran
    path = logpath + "/"+logfile
    try:
        with open(path, 'r')as Fi:
            i = Fi.readline()
            while i:
                CppTest = 1
                if "r(core dumped)" in i:
                    print ("Core dump Exception Occured\n ")
                s2 = re.search(p2, i)  # Search for Testcase name
                s1 = re.search(p1, i)  # Search for Testcase name ends with cama

                if s2:
                    if CppTest == 1:
                        i = Fi.readline()  # read the next line
                        TestList.append(s2.group(2))  # getting testcase name     Ex: 4 tests from UtilsBoxesTest/1.
                        passcount = 0  # counting no of test  passsed in a Testcase
                        while i:  # loop will continue until Testcase result came  #  4 tests from UtilsBoxesTest (0 ms total)

                            test = s2.group(2)
                            s3 = re.search(r'\[       OK \]', i)  # it it found the test is passed

                            if s3:
                                passcount = passcount + 1
                            else:
                                s4 = re.search(p4,
                                               i)  # Searching for endline if it came stop the test case  EX:  4 tests from UtilsBoxesTest (0 ms total)
                                if s4:
                                    break
                            i = Fi.readline()
                        PassList.append(passcount)  # represent no of test passes in single testcase
                        failed = int(s2.group(1)) - passcount  # Calculating failed test cases
                        NofTests.append(s2.group(1))  # No of test in Testcase
                        FailedList.append(failed)

                i = Fi.readline()
        for i in range(len(TestList)):  # Fillng stored data for prettytable.
            pt.add_row([TestList[i], NofTests[i], PassList[i], FailedList[i] ])
            totalpass = totalpass + int(PassList[i])
            totalfailed = totalfailed + int(FailedList[i])
            totaltests = totaltests + int(NofTests[i])

        print("\n=========================================================\nTest Runtime= %s Hours\n=========================================================\n"%runtime)
        #print("System Information\n")
        print("\nC++ Testcases\n")
        pt1.field_names = [" ", 'Testcases', 'Test', 'Passed', 'Failed']
        pt1.add_row([" Test Summary ", len(TestList), totaltests, totalpass, totalfailed])
        print (pt)
        print("C++ Testcase Summary\n")
        print (pt1)
        ######################################## Caffe2 python testcases start here.

        k = os.system(r"cat %s/%s | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | col -b > %s/%s" % (logpath,logfile, logpath, logfile))
        #os.remove('%s/c2logprint.log' % logpath)
        with open(logpath + '/' + logfile, 'r') as f:
            Line = f.readline()
            while Line:
                p1 = re.search(r'(\.py\:\:)(\w+)(\:*\.?\w+)', Line)
                if p1:
                    if p1.group(2) in Testname:
                        Pass = re.search(r'(\:\:)(%s)(\:*\.?\w+)' % (p1.group(2)), Line)

                        if Pass:

                            if (re.search('( ✓)', Line) or re.search('( PASSED )', Line)):
                                passcount = passcount + 1
                                Totpass = Totpass + 1
                        skipped = re.search(r'(\:\:)(%s)(\:*\.?\w+)' % (p1.group(2)), Line)
                        if skipped:
                            if (re.search(r' s ', Line) or re.search('( SKIPPED )', Line)):
                                skippedcount = skippedcount + 1
                                Totskipped = Totskipped + 1
                        failed = re.search(r'(\:\:)(%s)(\:*\.?\w+)' % (p1.group(2)), Line)
                        if failed:
                            if (re.search(r'( ⨯)', Line) or re.search('( FAILED )', Line)):
                                failedcount = failedcount + 1
                                Totfail = Totfail + 1
                        if flage == 0:
                            AtlTstname = p1.group(2)
                        LstTst[0] = p1.group(2)
                        LstTst[1] = passcount+failedcount+skippedcount
                        LstTst[2] = passcount
                        LstTst[3] = skippedcount
                        LstTst[4] = failedcount
                        flage = 1
                    else:
                        Testname = p1.group(2)
                        flage = 0
                        if flage == 0 and first == 1:
                            Tst.append(AtlTstname)
                            Tst.append(passcount+failedcount+skippedcount)
                            Tst.append(passcount)
                            Tst.append(skippedcount)
                            Tst.append(failedcount)
                            TotTst.append(Tst)

                            passcount = 0
                            failedcount = 0
                            skippedcount = 0
                            Tst = []

                else:
                    Line = f.readline()
                    p1 = re.search(r'(\.py\:\:\w+)(\:*\.?\w+)', Line)
                    if p1:
                        flage = 0

                if flage != 0:
                    Line = f.readline()
                    flage = 1
                    first = 1

        TotTst.append(LstTst)
        ptpy = PrettyTable()
        ptpy.field_names = ['Testcase Names',"Tests",'Passed', 'skipped', 'failures']
        for i in TotTst:
            ptpy.add_row(i)
        ptpy.align = 'l'
        ptpy2 = PrettyTable()
        if (Totpass == 0 and Totskipped == 0 and Totfail == 0):

            ptpy2.field_names = [" ", "Testcases","Tests", "Passed", "Skipped", "Failed"]
            ptpy2.add_row(["Test Summary", len(TotTst) - 1,Totpass+Totskipped+Totfail, Totpass, Totskipped, Totfail])
        else:
            ptpy2.field_names = [" ", "Testcases","Tests", "Passed", "Skipped", "Failed"]
            ptpy2.add_row(["Test Summary", len(TotTst), Totpass+Totskipped+Totfail,Totpass, Totskipped, Totfail])

        print ("Python Testcases")
        print (ptpy)
        print ("Python Test Summary")
        print (ptpy2)

        with open(logpath + r'/c2summery.html', 'w') as T:  # Storing for future use.
            txfile = open(logpath + '/' + summaryfile, 'w')
            T.write(HTML)
            T.write('<b>=========================================================<br>Test Runtime= %s Hours<br>=========================================================</b>'%runtime)
            T.write("</br><b>C++ Test Summary</b></br>")
            T.write(pt1.get_html_string())
            T.write("</br>")
            T.write("</br><b>Python Test Summary</b>")
            T.write(ptpy2.get_html_string())

            T.write("</br></br><b>C++ Testcases</b>")
            T.write(pt.get_html_string())
            T.write("</br><b>Python Testcases</b>")
            T.write(ptpy.get_html_string())
            #T.write('</br><b>System Information</b>')
            #T.write('</br>')
            #T.write(roc_ptable.get_html_string())

            txfile.write("\n=========================================================\nTest Runtime= %s Hours\n=========================================================\n"%runtime)
            txfile.write("C++ Test Summary\n")
            txfile.write(pt1.get_string())
            txfile.write("\n")
            txfile.write("Python Test Summary\n")
            txfile.write(ptpy2.get_string())
            txfile.write("\nC++ Testcases\n")
            txfile.write(pt.get_string())
            txfile.write('\n\n')
            txfile.write("\n\nPython Testcases\n")
            txfile.write(ptpy.get_string())
            txfile.write('\n\n')
            #txfile.write('System Information\n')
            #txfile.write(roc_ptable.get_string())
        
    except KeyboardInterrupt:
        print("Keyboard Inttrepution")
    except IOError:
        print("Raised when an input/ output operation fails, such as the print statement or the open()")


#################################################################################################################


def PytorchTest(logpath,logfile):
    '''
        This function launch the docker,run the pytorch unit test and generate the pretty table summary file,log files.

        :param dockerimage: it is a docker image name
        :param roc_ptable: it is rocmaster version prettytable object get from pre_requisites function.
        :param gpu: is useful  in multi gpu machine on which pytorch test need to run
        :return: it success it return 0
        '''
    #print (ActualTest_name)
    global test_name
    global mail_path
    #global logpath
    global summaryfile
    #logfile= filename +'pytorch'+ '_log.log'
    summaryfile = filename + "pytorch" + '_summary.txt'
    start=datetime.now()
    '''if 'pyc2' in ActualTest_name:
        if '+' in dockerimage:
            dockerimage=dockerimage.split('+')
            Dockerimage=dockerimage[0]
        else:
            print("Please provide pytoch docker image fallowed by '+'(no Space) fallowed by  caffe2 dockerimage\nExample: computecqe/pytorch:rocm24-RC3-25-ub1604+computecqe/caffe2:rocm24-RC3-25-ub1604"    )
            exit()
    else:
        Dockerimage=dockerimage
    print ("GPU name: %s"%str(gpu))
    print("Docker image  Name : %s"%Dockerimage)'''

    TotalTestcases = 0  # to print test case summary counting tecases results
    Totalskipped = 0
    TotalExpFail = 0
    Totalfailed = 0
    Totalpass = 0
    Totalerrors = 0
    test_name='pytorch'
    logpath =logpath 
    #logpath = os.path.expanduser(logpath)
    #logpath = logpath + '/PytorchLogs'
    '''if os.path.isdir(logpath):
        print ("deleting the logpath")
        os.system('echo AH64_uh1 | sudo rm -rf %s' % logpath)
    os.mkdir(logpath)
    mail_path = logpath
    #os.chmod(os.getcwd(),0o777)
    with open(logpath+'/'+logfile,'w') as f:
        #f.write(roc_ptable.get_string())
        f.write('\n')
    Path=r'cat /root/pytorch/test/run_test.py'
    if run_parallel_flag==0:
        Command=sub.call("echo AH64_uh1 | sudo docker run -i --network=host --rm --device=/dev/kfd --device=/dev/dri --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee run_test.txt"%(Dockerimage,Path),shell=True)
        
    else:
        Command=sub.call("echo AH64_uh1 |sudo docker run -i --network=host --rm --device=/dev/kfd --device=/dev/dri/%s --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee run_test.txt"%(gpu,Dockerimage,Path),shell=True)
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

    for i in block:
        if i in testcases:
            testcases.remove(i)
    Tests=testcases
    ActualTest=' '.join(testcases)
    print ("Pytorch Testcases: {}".format(Tests))
    Loopcount=0 #Loopcount for counting iterations
    Slice="" #Slice store's last ran test name

    while True:
        try:
            if Loopcount==0: # Start test case here
                Path=r'python /root/pytorch/test/run_test.py -v'

            else: #enter if it is seconf iteration
                if len(Slice)!=0: #checking slice is free or not
                    Index=re.search(r'\b%s\b'%(Slice),ActualTest).start() #get the index of Slice in Actural test
                    Index=Index+len(Slice)+1 # I point to the next test name to run
                    print (ActualTest[Index:])
                    Path=r'python /root/pytorch/test/run_test.py -v -i %s'%(ActualTest[Index:]) #Run the test with this command
            if run_parallel_flag==0:
                Command=sub.call(r"echo AH64_uh1 | sudo docker run --env PYTORCH_TEST_WITH_ROCM='1' -i --network=host --rm --device=/dev/kfd --device=/dev/dri --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee  %s/pylog.log"%(Dockerimage,Path,logpath),shell=True) #Pulling and Launching running unite
            else:
                Command=sub.call(r"echo AH64_uh1 | sudo docker run --env PYTORCH_TEST_WITH_ROCM='1' -i --network=host --rm --device=/dev/kfd --device=/dev/dri/%s --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee  %s/pylog.log"%(gpu,Dockerimage,Path,logpath),shell=True) #Pulling and Launching running unite
            #Command=sub.call(r"sudo docker run --env PYTORCH_TEST_WITH_ROCM='1' -i --network=host --device=/dev/kfd --device=/dev/dri --group-add video -v $HOME/dockerx:/dockerx %s %s 2>&1 | tee  %s/pylog.log"%(Dockerimage,Path,logpath),shell=True) #Pulling and Launching running unite
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

            with open(Path,'r',) as Fi:
                #print "Reading file"
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
                        TestName.append(Name.group(2))
                        L1=1
                        Slice= Name.group(2)
                        Slice=Slice.replace("test_",'') # getting corrent running testcase name for future use
                    elif(testrun and L1 and L2==0):
                        RunTests.append(testrun.group(2))
                        L2=1
                    elif((result or result1) and L1 and L2):
                        Result.append(i.rstrip())
                        L1=0
                        L2=0
                    else:
                        pass

        except IndexError:
            os.system(r'cat %s/pylog.log >> %s/%s'%(logpath,logpath,logfile))
            break
            print("Raised when an index is not found in a sequence.")
        except KeyboardInterrupt:
            os.system(r'cat %s/pylog.log >> %s/%s'%(logpath,logpath,logfile))
            break
            print ("Raised when the user interrupts program execution")
        except IOError:
            break
            os.system(r'cat %s/pylog.log >> %s/%s'%(logpath,logpath,logfile))
            print("Raised when an input/ output operation fails, such as the print statement or the open()")

        if Tests[-1] in Slice:
            os.system(r'cat %s/pylog.log >> %s/%s'%(logpath,logpath,logfile))
            break
        else: # if tstcases failed it will skip the failed and continue next test using Slice and Loopcount
            os.system(r'cat %s/pylog.log >> %s/%s'%(logpath,logpath,logfile))
            #print Slice
        Loopcount=Loopcount+1'''
    runtime=datetime.now()-start
    print (runtime)

    try:
        Running=re.compile(r'(Running) (test_\w+) (\.\.\. \[\d+)') #This is for searching test name
        skipped=re.compile(r'skipped ')
        passed=re.compile(r'\bok\b')
        failed=re.compile(r'\.+ FAIL')
        Errored=re.compile(r'\.+ ERROR')
        Expf=re.compile(r'\.+ expected failure')
        TestName=[]
        Result=[]
        RunTests=[]
        passcount=0;failcount=0; skipcount=0; errorcount=0;expcount=0;count=0
        Slice=""
        print("Running Test ")
        with open(logpath+'/'+logfile,'r',) as Fi:
            for i in Fi: #Reading single line at a time
            #print i
                Name=re.search(Running,i) # searching for testcase name
                Skip=re.search(skipped,i) # search for total tests
                Fail=re.findall(failed,i) # search for pass
                Pass=re.search(passed,i) # search for fail
                Error=re.search(Errored,i)
                Expect=re.search(Expf,i)

                if(Name):
                    if count!=0:
                        TestName.append(Name.group(2))

                        Result.append(Slice)
                        AllTest=passcount+skipcount+failcount+errorcount+expcount
                        Result.append(AllTest)
                        Result.append(passcount)
                        Result.append(failcount)
                        Result.append(errorcount)
                        Result.append(skipcount)
                        Result.append(expcount)
                        RunTests.append(Result)
                        Result=[]

                        #print RunTests
                    Slice= Name.group(2)

                    count=count+1
                    passcount=0; failcount=0; skipcount=0;errorcount=0; expcount=0;AllTest=0
                elif(Skip):
                    skipcount=skipcount+1

                elif(Fail):
                    failcount=failcount+1
                elif(Pass):
                    passcount=passcount+1
                elif(Error):
                    errorcount=errorcount+1
                elif(Expect):
                    expcount=expcount+1

                else:
                    pass

        Result.append(Slice)
       # Result.append(passcount+skipcount+failcount+errorcount)

        AllTest=passcount+skipcount+failcount+errorcount+expcount
        Result.append(AllTest)
        Result.append(passcount)
        Result.append(failcount)
        Result.append(errorcount)
        Result.append(skipcount)
        Result.append(expcount)
        RunTests.append(Result)
        pt=PrettyTable()
        pt1=PrettyTable()
        pt.field_names = ['TestName', 'Tests', 'Passed ', 'Failures', "Errors", 'Skipped', 'Expected failures']
        pt.align='l'
        pt1.align='l'
        for i in RunTests:
            pt.add_row(i)
            TotalTestcases=TotalTestcases+i[1]
            Totalpass=Totalpass+i[2]
            Totalfailed=Totalfailed+i[3]
            Totalerrors=Totalerrors+i[4]
            Totalskipped=Totalskipped+i[5]
            TotalExpFail=TotalExpFail+i[6]
        pt1.field_names = [" ", "Testcases", 'Tests','Passed', 'Failed', "Errors", 'Skipped', 'Expected failures ']
        pt1.add_row(["Total Summary", len(RunTests), TotalTestcases, Totalpass, Totalfailed, Totalerrors, Totalskipped, TotalExpFail])
        print("\n=========================================================\nTest Runtime= %s Hours\n========================================================="%runtime)
        print("Pytorch Testcases.")
        print (pt)
        print ("Pytorch Testcase summary\n")
        print (pt1)

        with open(logpath + r'/pytorchsummary.html', 'w')as f:  # Storing pretty table for future use
            txfile = open(logpath + r'/' + summaryfile, 'w')
            f.write(HTML)
            f.write('<b>=========================================================<br>Test Runtime= %s Hours<br>=========================================================</b>'%runtime)
            f.write("<br><b>Pytorch Test Summary</b>")
            f.write(pt1.get_html_string())
            f.write("</br><b>Pytorch Testcase </b>")
            f.write(pt.get_html_string())
            #f.write('</br><b>System information</b>')
            #f.write(roc_ptable.get_html_string())
            txfile.write("\n=========================================================\nTest Runtime= %s Hours\n=========================================================\n"%runtime)
            txfile.write("Pytorch Test Summary\n")
            txfile.write(pt1.get_string())
            txfile.write('\n')
            txfile.write("\nPytorch Testcase\n")
            txfile.write(pt.get_string())
            #txfile.write('\nSystem information\n')
            #txfile.write(roc_ptable.get_string())
    except KeyboardInterrupt:
        print ("Raised when the user interrupts program execution")
    except IOError:
        print("Raised when an input/ output operation fails, such as the print statement or the open()")
    if os.path.isfile('%s/pylog.log' % logpath):
        os.remove('%s/pylog.log' % logpath)
  
if __name__=='__main__':
    print (sys.argv[1])
    
    if "pytorch" in sys.argv[1]:
        print("In pytorch")
        PytorchTest(sys.argv[2],sys.argv[3])
    elif 'caffe2' in sys.argv[1]:
        print("In caffe2")
        Caffe2Test(sys.argv[2],sys.argv[3])


   
