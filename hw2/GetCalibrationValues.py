#!/usr/bin/python3
import sys
import re

#assumption: each line of calibration file must have at least 1 digit
def get_calibration_values(ifile:str):

    first_digit = re.compile(r'\D*(\d).*')
    last_digit = re.compile(r'.*(\d)\D*')

    with open(ifile, mode="r", encoding="utf-8") as file_handle:
        calib_txt = file_handle.read()

    first_digit_result = first_digit.findall(calib_txt)
    last_digit_result = last_digit.findall(calib_txt)

    calib_values = []
    for idx, digit in enumerate(first_digit_result):
        value = int(digit + last_digit_result[idx])
        #print(value)
        calib_values.append(value)

    return calib_values

if __name__ == "__main__":
    result = get_calibration_values(sys.argv[1])
    print(result)