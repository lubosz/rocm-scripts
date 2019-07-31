#!/bin/bash
cd /root/pytorch
LOGDIR=/dockerx
export PYTORCH_TEST_WITH_ROCM=1 
echo "========================= py-autograd====================="
python3 test/test_autograd.py -v 2>&1 | tee $LOGDIR/py-autograd.log
echo "========================= caffe2 cuda====================="
python3 test/test_cuda.py -v 2>&1 | tee $LOGDIR/py-cuda.log	
echo "========================= py-dataloader ====================="
python3 test/test_dataloader.py	-v 2>&1 | tee $LOGDIR/py-dataloader.log
echo "========================= py-distributions====================="
python3 test/test_distributions.py -v 2>&1 | tee $LOGDIR/py-distributions.log
echo "========================= py-indexing====================="
python3 test/test_indexing.py -v 2>&1 | tee $LOGDIR/py-indexing.log
echo "========================= py-jit====================="
python3 test/test_jit.py -v 2>&1 | tee $LOGDIR/py-jit.log	
echo "========================= py-nn====================="
python3 test/test_nn.py	-v 2>&1 | tee $LOGDIR/py-nn.log	
echo "========================= py-optim===================="
python3 test/test_optim.py	-v 2>&1 | tee $LOGDIR/py-optim.log
echo "========================= py-sparse====================="
python3 test/test_sparse.py	-v 2>&1 | tee $LOGDIR/py-sparse.log	
echo "========================= py-torch====================="
python3 test/test_torch.py -v 2>&1 | tee $LOGDIR/py-torch.log
echo "========================= py-utils====================="
python3 test/test_utils.py -v 2>&1 | tee $LOGDIR/py-utils.log
