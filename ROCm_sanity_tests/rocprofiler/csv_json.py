import csv
import json

csvfile = open('out.csv', 'r')
jsonfile = open('file.json', 'w')

fieldnames = ("Index","KernelName","DispatchNs","BeginNs","EndNs","CompleteNs","GRBM_COUNT","GRBM_GUI_ACTIVE","SQ_WAVES","SQ_INSTS_VALU","SQ_INSTS_VMEM_WR","SQ_INSTS_VMEM_RD","SQ_INSTS_SALU","SQ_INSTS_SMEM","SQ_INSTS_FLAT","SQ_INSTS_FLAT_LDS_ONLY","TA_TA_BUSY[0]","TA_FLAT_READ_WAVEFRONTS","TCC_HIT","TCC_MISS","TCC_EA_WRREQ","TCC_EA_WRREQ_64B","TCP_TA_DATA_STALL_CYCLES")
reader = csv.DictReader( csvfile, fieldnames)
for row in reader:
    json.dump(row, jsonfile)
    jsonfile.write('\n')
