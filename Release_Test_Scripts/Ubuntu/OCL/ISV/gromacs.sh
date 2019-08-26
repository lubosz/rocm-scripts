cd ~/Desktop/Tests/OCL/Gromacs/gromacs
export GMX_OCL_FILE_PATH=~/Desktop/Tests/OCL/Gromacs/gromacs/share/gromacs/opencl
echo "Gromacs -- WithOpenCL -- d.poly" >> ~/Desktop/logs/gromacs.log 2>&1
cd ~/Desktop/Tests/OCL/Gromacs/gromacs/build/bin/d.poly-ch2/
../gmx grompp
../gmx mdrun >> ~/Desktop/logs/gromacs.log 2>&1
echo "----------------------------------------"
echo "----------------------------------------"
echo "Gromacs -- WithOpenCL -- adh_Cubic" >> ~/Desktop/logs/gromacs.log 2>&1
cd ~/Desktop/Tests/OCL/Gromacs/gromacs/build/bin/adh_cubic_vsites/
../gmx grompp -f pme_verlet_vsites.mdp
../gmx mdrun >> ~/Desktop/logs/gromacs.log 2>&1
echo "----------------------------------------"
echo "----------------------------------------"
echo "Gromacs -- WithOpenCL -- rnase_cubic" >> ~/Desktop/logs/gromacs.log 2>&1
cd ~/Desktop/Tests/OCL/Gromacs/gromacs/build/bin/rnase_cubic/
../gmx grompp -f pme_verlet.mdp
../gmx mdrun >> ~/Desktop/logs/gromacs.log 2>&1
echo "----------------------------------------"
echo "----------------------------------------"
echo "Gromacs -- WithOpenCL -- villin_vsites" >> ~/Desktop/logs/gromacs.log 2>&1
cd ~/Desktop/Tests/OCL/Gromacs/gromacs/build/bin/villin_vsites/
../gmx grompp -f pme_verlet_vsites.mdp
../gmx mdrun >> ~/Desktop/logs/gromacs.log 2>&1
echo "----------------------------------------"
echo "----------------------------------------"
echo "Gromacs -- WithOpenCL -- water-cut" >> ~/Desktop/logs/gromacs.log 2>&1
cd ~/Desktop/Tests/OCL/Gromacs/gromacs/build/bin/water-cut1.0_GMX50_bare/0024/
../../gmx grompp -f pme.mdp
../../gmx mdrun >> ~/Desktop/logs/gromacs.log 2>&1
echo "----------------------------------------"
echo "----------------------------------------"
