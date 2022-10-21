""" This file is used for unittest of HI service"""
import copy
import json
import os
import tempfile

THIS_FOLDER = os.path.dirname(os.path.abspath(__file__))


def hi_request(client, hi_file, file_format=".json"):
    """
    Utility function to perform rest request
    Args:
        client:
        hi_file:
        file_format:

    Returns:

    """
    files = {"hi_input": (f"hi_file{file_format}", hi_file, "application/json")}

    return client.post(
        '/api/hi',
        files=files
    )


def test_hi_200_sanity(client):
    """

    Args:
        client:
        
    Returns:

    """

    hi_file = f"{THIS_FOLDER}/data/sample-hi-input.json"
    with open(hi_file, 'rb') as fdata:
        hi_data = fdata.read()
    response = hi_request(
        client=client,
        hi_file=hi_data
    )

    response_data = response.json()
    assert response.status_code == 200
    assert response_data["requestRefId"] == "RQ_ID_ABC_123"
    assert len(response_data["healthIndicatorOutputs"]) == 2
    response_array = response_data["healthIndicatorOutputs"]
    response_item = response_array[0]
    assert len(response_item["healthIndicatorValues"]) == 1


def test_hi_csv_file(client, hi_data):
    hi_data_copy = copy.deepcopy(hi_data)

    temporary_file = tempfile.NamedTemporaryFile(prefix="hi_file", suffix=".csv", mode="w+")
    json.dump(hi_data_copy, temporary_file)
    temporary_file.seek(0)

    response = hi_request(
        client=client,
        hi_file=temporary_file,
        file_format=".csv"
    )
    temporary_file.close()

    response_data = response.json()
    assert response.status_code == 400
    assert response_data["Status"] == "Unsuccessful"
    assert len(response_data.keys()) == 4
    assert response_data[
               'ErrorMessage'] == "Service does not support file format : csv. The only supported format is 'json' for now."
