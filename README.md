# qa-serverest-yuri-galdino

This repository contains automated tests for the Serverest API and Front-End. The tests are written using Robot Framework.

## Prerequisites

Before running the tests, make sure you have the following installed:

- Python 3.x
- Robot Framework
- RequestsLibrary
- Collections Library

You can install the required libraries using pip:

```sh
pip install robotframework
pip install robotframework-requests
pip install robotframework-collections
```

## Running the Tests

### Running All E2E Tests

You can run all the available `E2E` tests with the following command:

```sh
robot -i E2E <your path to the root of this project>
```

Replace `<your path to the root of this project>` with the actual path to the root of this project.

### Running All API Tests

You can run all the available `API` tests with the following command:

```sh
robot -i API <your path to the root of this project>
```

Replace `<your path to the root of this project>` with the actual path to the root of this project.


### Running Individual Test Cases

You can run individual test cases using the `-t` option. For example, to run a specific test case:

```sh
robot -t "Name of The Test Case" <file.robot>
```

You need to be in the same folder of the mentioned file.robot in order to work.

### Headless or GUI Run

It is possible to choose between a headless run or the common GUI run by changing the `HEADLESS` variable in `variables/project_variables.robot`:

```robotframework
*** Variables ***

# Set as True for HEADLESS RUN or False for GUI RUN
${HEADLESS}     True
```

Set `${HEADLESS}` to `True` for a headless run or `False` for a GUI run.

## Project Structure

- `tests/`: Contains the test cases for the API and frontend.
- `resources/`: Contains the resource files used by the tests.
- `variables/`: Contains the variable files used by the tests.

## Test Robustness and Resilience

The test structure is designed with a certain level of robustness and resilience. If a user or admin does not exist in the database, or if the most recent token has expired, the tests are still capable of being executed. For GET, POST, and DELETE API tests, the code always checks the necessary conditions before performing the actions. For example, when deleting a product, if the product does not exist on the platform, it will be created first, and only then will the DELETE action be performed.

## Contributing

If you would like to contribute to this project, please fork the repository and submit a pull request.
##
<p align="center"><img src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ3hwYjl4YTQ3a2JrdnozcjRiaXZkaHFicmFja2dybHdvM2RoZHl6bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZY2DmHSTFpmmEH5STD/giphy.gif" alt="this slowpoke moves"  width="480" /></p>
