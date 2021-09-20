#!/bin/bash
# This program obtains:
#   - MeasEpoch2
#   - ChannelStatus
# data from an SBF file 
# -------------------------------
INPUT_PATH='/media/cesar/Septentrio03/Binary/'
OUTPUT_PATH='/home/cesar/Desktop/luisd/scripts/Graficas_desvanecimientos/Input_data/Data_set/'
COMPARE_PATH1='/media/cesar/Septentrio03/ISMR/'
COMPARE_PATH2='/home/cesar/Desktop/luisd/scripts/Graficas_desvanecimientos/Input_data/Data_binary/'
CONVERTER='/opt/Septentrio/RxTools/bin/bin2asc'

FOLDERS=`diff -q ${COMPARE_PATH1} ${COMPARE_PATH2} | grep Only | grep ${COMPARE_PATH1} | awk '{print $4}'`

if [[ -z $FOLDERS ]]
then 
  echo "There isn't any new file yet!"
else
  echo "The new files are:"
  echo $FOLDERS
  for FOLDER in $FOLDERS
  do
    # Get MeasEpoch2 ascii file  
    ls ${INPUT_PATH}${FOLDER}/*_ | xargs -t -I % ${CONVERTER} -f % -m MeasEpoch2 -t -x -i 1
    mv ${INPUT_PATH}${FOLDER}/*MeasEpoch*.txt ${OUTPUT_PATH} 
    
    # Get ChannelStatus ascii file  
    ls ${INPUT_PATH}${FOLDER}/*_ | xargs -t -I % ${CONVERTER} -f % -m ChannelStatus -t -x -i 1
    mv ${INPUT_PATH}${FOLDER}/*ChannelStatus*.txt ${OUTPUT_PATH} 
    mkdir ${COMPARE_PATH2}${FOLDER}
  done
  echo "All binary files were converted sucesfully!"
fi

