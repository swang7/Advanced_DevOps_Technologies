import argparse
import GetCalibrationValues

parser = argparse.ArgumentParser(prog="ElfGetCalibration",
                                 description="Retrieve the calibration number from input file")

parser.add_argument('calibration_file')

args = parser.parse_args()
calib_values = GetCalibrationValues.get_calibration_values(args.calibration_file)
print(f"sum of all of the calibration values is: {sum(calib_values)}")