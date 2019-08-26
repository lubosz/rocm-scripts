cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/OpenMM_OpenCL/bin
echo AH64_uh1 | sudo -S rm -rf /tmp/*
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

./TestOpenCLCheckpoints   > ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCMAPTorsionForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCMMotionRemover >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCompoundIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomAngleForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomBondForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomCentroidBondForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomCompoundBondForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomExternalForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomGBForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomHbondForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomManyParticleForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomTorsionForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLDeviceQuery >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLDrudeForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLDrudeLangevinIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLDrudeSCFIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLEwald >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLFFT >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLHarmonicAngleForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLHarmonicBondForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLLangevinIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLLocalEnergyMinimizer >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLMonteCarloAnisotropicBarostat >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLMonteCarloBarostat >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLMultipleForces >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLPeriodicTorsionForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLRandom >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLRBTorsionForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLRpmd >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLSettle >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLSort >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLVariableLangevinIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLVariableVerletIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLVerletIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLVirtualSites >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLCustomNonbondedForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLGBSAOBCForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLNonbondedForce >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLBrownianIntegrator >> ~/Desktop/logs/OpenMM.log 2>&1
./TestOpenCLAndersenThermostat >> ~/Desktop/logs/OpenMM.log 2>&1

