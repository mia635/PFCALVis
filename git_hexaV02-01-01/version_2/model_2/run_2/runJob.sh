#!/bin/bash
source /afs/cern.ch/user/o/ocolegro/HGCAL_ALEX3/Project-repo/g4env.sh
cp /afs/cern.ch/user/o/ocolegro/HGCAL_ALEX3/Project-repo/git_hexaV02-01-01/version_2/model_2//run_2//g4steer.mac .
PFCalEE g4steer.mac 2 2 0.000000 1 | tee g4.log
mv PFcal.root HGcal__version2_model2_thick1_run2.root
localdir=`pwd`
echo "--Local directory is " $localdir >> g4.log
ls * >> g4.log
grep "alias eos=" /afs/cern.ch/project/eos/installation/cms/etc/setup.sh | sed "s/alias /export my/" > eosenv.sh
source eosenv.sh
$myeos mkdir -p /store/user/mullin/test_target/githexaV02-01-01
$myeos cp HGcal__version2_model2_thick1_run2.root /eos/cms/store/user/mullin/test_target/githexaV02-01-01/HGcal__version2_model2_thick1_run2.root
if (( "$?" != "0" )); then
echo " --- Problem with copy of file PFcal.root to EOS. Keeping locally." >> g4.log
fi
rm HGcal__version2_model2_thick1_run2.root
echo "--deleting core files: too heavy!!"
rm core.*
cp * /afs/cern.ch/user/o/ocolegro/HGCAL_ALEX3/Project-repo/git_hexaV02-01-01/version_2/model_2//run_2//
echo "All done"
