import os
import subprocess
import sys


def find_test_cases(root_dir):
    test_cases = []
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith(".in"):
                input_file = os.path.join(root, file)
                output_file = os.path.join(root, file[:-3] + ".ans")
                if os.path.exists(output_file):
                    test_cases.append((input_file, output_file))
    return test_cases


def run_test(solver_path, input_file, output_file):
    with open(input_file, "r") as f:
        input_data = f.read()

    result = subprocess.run(
        [sys.executable, solver_path], input=input_data, capture_output=True, text=True
    )

    with open(output_file, "r") as f:
        expected_output = f.read().strip()

    actual_output = result.stdout.strip()

    return actual_output == expected_output, actual_output, expected_output


def main():
    solver_path = "main4.py"
    data_dir = "SL/data"

    test_cases = find_test_cases(data_dir)
    total_tests = len(test_cases)
    passed_tests = 0

    for i, (input_file, output_file) in enumerate(test_cases, 1):
        print(f"Running test case {i}/{total_tests}: {input_file}")
        passed, actual, expected = run_test(solver_path, input_file, output_file)

        if passed:
            passed_tests += 1
            print("PASSED")
        else:
            print("FAILED")
            print(f"Expected output:\n{expected}")
            print(f"Actual output:\n{actual}")

        print()

    print(f"Test results: {passed_tests}/{total_tests} passed")


if __name__ == "__main__":
    main()
