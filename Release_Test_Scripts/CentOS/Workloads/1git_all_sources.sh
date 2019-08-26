loc="$HOME/Desktop/"
logfile=lc_$(date +'%B-%d').log
final_logfile=$loc$logfile

cd $HOME/Desktop/
echo AH64_uh1 | sudo -S rm -rf rocm_old
echo AH64_uh1 | sudo -S mv -f rocm rocm_old
mkdir rocm && cd rocm

echo "Component     CommitID                                      CommitDate" >> $final_logfile
echo "======================================================================" >> $final_logfile

mkdir workloads && cd workloads

#git clone https://github.com/amdcomputelibraries/computeapps && cd computeapps
#printf "computeapps       " >> $final_logfile
#git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
#printf "        " >> $final_logfile
#git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
#printf "\n" >> $final_logfile

#cd ..

mkdir mathlibs && cd mathlibs

git clone -b master https://github.com/rocmsoftwareplatform/rocblas && cd rocblas
printf "rocblas           " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b master https://github.com/rocmsoftwareplatform/hipblas && cd hipblas
printf "hipblas           " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b master https://github.com/rocmsoftwareplatform/rocfft && cd rocfft
printf "rocfft            " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b master https://github.com/rocmsoftwareplatform/rocrand && cd rocrand
printf "rocrand            " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b master https://github.com/rocmsoftwareplatform/rocprim && cd rocprim
printf "rocprim            " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b master https://github.com/rocmsoftwareplatform/rocsparse && cd rocsparse
printf "rocsparse          " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b master https://github.com/rocmsoftwareplatform/hipsparse && cd hipsparse
printf "hipsparse          " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b master https://github.com/rocmsoftwareplatform/rocalution && cd rocalution
printf "rocalution         " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b master https://github.com/rocmsoftwareplatform/rocthrust && cd rocthrust
printf "rocthrust          " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..


git clone -b master https://github.com/rocmsoftwareplatform/hipcub && cd hipcub
printf "hipcub             " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..


cd ..

mkdir DNNs && cd DNNs

git clone -b develop https://streamhsa:AH64_uh1@github.com/amdcomputelibraries/mlopen miopen-hip && cd miopen-hip
printf "miopen-ocl        " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..

git clone -b develop https://streamhsa:AH64_uh1@github.com/amdcomputelibraries/mlopen miopen-ocl && cd miopen-ocl
printf "miopen-ocl        " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..


#git clone https://github.com/rocmsoftwareplatform/hipcaffe && cd hipcaffe
#printf "hipcaffe          " >> $final_logfile
#git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
#printf "        " >> $final_logfile
#git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
#printf "\n" >> $final_logfile
#cd ..

git clone https://github.com/rocmsoftwareplatform/deepbench && cd deepbench
printf "deepbench         " >> $final_logfile
git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
printf "        " >> $final_logfile
git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
printf "\n" >> $final_logfile
cd ..


cd ..

#mkdir hip_tests && cd hip_tests

#git clone -b develop https://streamhsa:AH64_uh1@github.com/rocmsoftwareplatform/hipeigen && cd hipeigen
#printf "hipeigen          " >> $final_logfile
#git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
#printf "        " >> $final_logfile
#git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
#printf "\n" >> $final_logfile
#cd ..

#cd ..

#mkdir miniapps && cd miniapps

#git clone -b master https://github.com/kokkos/kokkos && cd kokkos
#printf "kokkos            " >> $final_logfile
#git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
#printf "        " >> $final_logfile
#git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
#printf "\n" >> $final_logfile
#cd ..

#git clone https://github.com/gromacs/gromacs && cd gromacs
#printf "gromacs           " >> $final_logfile
#git log | grep -m 1 commit | awk '{printf $2}'>> $final_logfile
#printf "        " >> $final_logfile
#git log | grep -m 1 Date | awk '{printf $3; printf $4}' >> $final_logfile
#printf "\n" >> $final_logfile
#cd ..

