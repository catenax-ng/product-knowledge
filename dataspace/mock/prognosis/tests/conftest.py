""" File contains all the fixtures needed for the tests, this file
would be run before any other by pytest """

import pytest
from fastapi.testclient import TestClient
from run import app


@pytest.fixture()
def client(monkeypatch):
    """
    A factory which provides a Test client instance
    """
    monkeypatch.setenv("ENV", "test")
    monkeypatch.setenv("PG_USERNAME", "SampleUser")
    monkeypatch.setenv("PG_PASSWORD", "SamplePassword")
    yield TestClient(app=app)


@pytest.fixture(scope="module")
def lc_data():
    """
    Factory that yields the data, which can be used by multiple tests
    """
    data = {
        "File": {
            "Type": "ZF_load_collective",
            "Version": "1.7"
        },
        "Header": {
            "CountingMethod": "ZF_TimeAtLevel",
            "CountingUnit": "s",
            "Channels": [
            {
                "Name": "Temp_Oil",
                "Type": "Load",
                "Unit": "degC",
                "LowerLimit": -40,
                "UpperLimit": 220,
                "NumberOfBins": 52
            }
            ]
        },
        "Body": {
            "Temp_Oil-class": [2, 3, 4, 6, 7, 8, 12, 18, 20, 22, 23, 25, 28, 29, 31,
                               32, 33, 34, 36, 37, 38, 41, 42, 43, 44, 45, 46, 47, 48,
                               49, 50, 51],
            "Counts": [1.234E+01, 2.345E+02, 1.654E+02, 4.321E+01, 6.098E+01, 3.432E+02,
                       1.873E+02, 4.738E+01, 6.927E+01, 1.234E+01, 2.345E+02, 1.654E+02,
                       2.983E+01, 2.983E+01, 4.321E+01, 3.876E+02, 5.567E+01, 3.4456E+02,
                       4.556645E+02, 5.678E+01, 4.321E+01, 3.876E+02, 5.567E+01, 3.4456E+02,
                       4.556645E+02, 5.678E+01, 4.321E+01, 6.098E+01, 3.432E+02, 1.873E+02,
                       4.738E+01, 6.927E+01]
        },
        "Metadata": {
            "OEM": "Sample",
            "VIN": 8655389761,
            "Component": "Oil",
            "Mileage": {
                "Value": 78954, "Unit": "km"
            },
            "RegistrationDate": {
                "Value": 20121209,
                "Unit": "yyyymmdd"
            }
        }
    }
    yield data

@pytest.fixture(scope="module")
def hi_data():
    """
    Factory that yields the data, which can be used by multiple tests
    """
    data = {
        "File": {
            "Type": "ZF_load_collective",
            "Version": "1.7"
        },
        "Header": {
            "CountingMethod": "ZF_TimeAtLevel",
            "CountingUnit": "s",
            "Channels": [
            {
                "Name": "Temp_Oil",
                "Type": "Load",
                "Unit": "degC",
                "LowerLimit": -40,
                "UpperLimit": 220,
                "NumberOfBins": 52
            }
            ]
        },
        "Body": {
            "Temp_Oil-class": [2, 3, 4, 6, 7, 8, 12, 18, 20, 22, 23, 25, 28, 29, 31,
                               32, 33, 34, 36, 37, 38, 41, 42, 43, 44, 45, 46, 47, 48,
                               49, 50, 51],
            "Counts": [1.234E+01, 2.345E+02, 1.654E+02, 4.321E+01, 6.098E+01, 3.432E+02,
                       1.873E+02, 4.738E+01, 6.927E+01, 1.234E+01, 2.345E+02, 1.654E+02,
                       2.983E+01, 2.983E+01, 4.321E+01, 3.876E+02, 5.567E+01, 3.4456E+02,
                       4.556645E+02, 5.678E+01, 4.321E+01, 3.876E+02, 5.567E+01, 3.4456E+02,
                       4.556645E+02, 5.678E+01, 4.321E+01, 6.098E+01, 3.432E+02, 1.873E+02,
                       4.738E+01, 6.927E+01]
        },
        "Metadata": {
            "OEM": "Sample",
            "VIN": 8655389761,
            "Component": "Oil",
            "Mileage": {
                "Value": 78954, "Unit": "km"
            },
            "RegistrationDate": {
                "Value": 20121209,
                "Unit": "yyyymmdd"
            }
        }
    }
    yield data
