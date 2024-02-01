#!/usr/bin/bash
set -o errexit; set -o pipefail; set -o nounset

if [ $# -ne 1 ]; then
    echo "Usage: $0 <calibration-file>"
    exit 0
fi

ifile=$1
if ! test -f $ifile ; then
  echo "File $argv[1] does not exist."
fi

#conver python list to bash array
calibration_values=($(./GetCalibrationValues.py $ifile | tr -d '[],'))
sum=0
for idx in ${!calibration_values[@]}; do
    if [ $(((idx + 1) % 3)) -eq 0 ]; then
        sum=$((sum + ${calibration_values[idx]}))
    fi
done

echo "sum of all the accurate calibration values is: $sum"
