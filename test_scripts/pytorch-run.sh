#!/bin/bash
cd /root/pytorch
LOGDIR=/dockerx
export PYTORCH_TEST_WITH_ROCM=1 
echo "========================= py-autograd====================="
python test/test_autograd.py -v 2>&1 | tee $LOGDIR/py-autograd.log
echo "========================= py-cuda====================="
python test/test_cuda.py -v 2>&1 | tee $LOGDIR/py-cuda.log	
echo "========================= py-dataloader ====================="
python test/test_dataloader.py	-v 2>&1 | tee $LOGDIR/py-dataloader.log
echo "========================= py-distributions====================="
python test/test_distributions.py -v 2>&1 | tee $LOGDIR/py-distributions.log
echo "========================= py-indexing====================="
python test/test_indexing.py -v 2>&1 | tee $LOGDIR/py-indexing.log
echo "========================= py-jit====================="
python test/test_jit.py -v 2>&1 | tee $LOGDIR/py-jit.log	
echo "========================= py-nn====================="
python test/test_nn.py	-v 2>&1 | tee $LOGDIR/py-nn.log	
echo "========================= py-optim===================="
python test/test_optim.py	-v 2>&1 | tee $LOGDIR/py-optim.log
echo "========================= py-sparse====================="
python test/test_sparse.py	-v 2>&1 | tee $LOGDIR/py-sparse.log	
echo "========================= py-torch====================="
python test/test_torch.py -v 2>&1 | tee $LOGDIR/py-torch.log
echo "========================= py-utils====================="
python test/test_utils.py -v 2>&1 | tee $LOGDIR/py-utils.log
echo "========================= py-test_cuda_primary_ctx====================="
python test/test_cuda_primary_ctx.py -v 2>&1 | tee $LOGDIR/test_cuda_primary_ctx.log
echo "========================py-test_indexing_cuda====================="
python test/test_indexing_cuda.py -v 2>&1 | tee $LOGDIR/test_indexing_cuda.log
echo "========================= py-test_numba_integration ====================="
python test/test_numba_integration.py   -v 2>&1 | tee $LOGDIR/py-test_numba_integration.log
echo "========================= py-test_type_info====================="
python test/test_type_info.py -v 2>&1 | tee $LOGDIR/py-test_type_info.log
echo "========================= py-test_type_hints====================="
python test/test_type_hints.py -v 2>&1 | tee $LOGDIR/py-test_type_hints.log
echo "========================= py-test_expecttest====================="
python test/test_expecttest.py -v 2>&1 | tee $LOGDIR/py-test_expecttest.log
echo "========================= py-test_docs_coverage====================="
python test/test_docs_coverage.py -v 2>&1 | tee $LOGDIR/py-test_docs_coverage.log
echo "========================= py-test_quantized====================="
python test/test_quantized.py -v 2>&1 | tee $LOGDIR/py-test_quantized.log
echo "========================= py-test_logging====================="
python test/test_logging.py -v 2>&1 | tee $LOGDIR/py-test_logging.log
echo "========================= py-test_mkldnn====================="
python test/test_mkldnn.py -v 2>&1 | tee $LOGDIR/py-test_mkldnn.log
echo "========================= py-test_namedtuple_return_api====================="
python test/test_namedtuple_return_api.py -v 2>&1 | tee $LOGDIR/py-test_namedtuple_return_api.log
echo "========================= py-test_jit_fuser====================="
python test/test_jit_fuser.py -v 2>&1 | tee $LOGDIR/py-test_jit_fuser.log
echo "========================= py-test_tensorboard====================="
python test/test_tensorboard.py -v 2>&1 | tee $LOGDIR/py-test_tensorboard.log
echo "========================= py-test_namedtensor====================="
python test/test_namedtensor.py -v 2>&1 | tee $LOGDIR/py-test_namedtensor.log
echo "========================= py-test_dist_autograd====================="
python test/test_dist_autograd.py -v 2>&1 | tee $LOGDIR/py-test_dist_autograd.log
echo "========================= py-test_fake_quant====================="
python test/test_fake_quant.py -v 2>&1 | tee $LOGDIR/py-test_fake_quant.log