""" This file is used for unittest of RUL service"""
import copy
import json
import os
import tempfile

THIS_FOLDER = os.path.dirname(os.path.abspath(__file__))


def damage_matrix(client, lc_file, file_format=".json"):
    """
    Utility function to perform rest request
    Args:
        client:
        lc_file:
        file_format:

    Returns:

    """
    files = {"load_collective_file": (f"lc_file{file_format}", lc_file, "application/json")}

    return client.post(
        '/api/rul',
        files=files
    )


def test_rul_200_sanity(client):
    """

    Args:
        client:
        lc_data:

    Returns:

    """

    lc_file = f"{THIS_FOLDER}/data/Fzg1_LCollective.json"
    with open(lc_file, 'rb') as fdata:
        lc_data = fdata.read()
    response = damage_matrix(
        client=client,
        lc_file=lc_data
    )

    response_data = response.json()
    assert response.status_code == 200
    assert response_data["Status"] == "Successful"
    assert len(response_data.keys()) == 3
    assert len(response_data["RUL"]["RUL"].keys()) == 2


def test_rul_csv_file(client, lc_data):
    lc_data_copy = copy.deepcopy(lc_data)

    temporary_file = tempfile.NamedTemporaryFile(prefix="lc_file", suffix=".csv", mode="w+")
    json.dump(lc_data_copy, temporary_file)
    temporary_file.seek(0)

    response = damage_matrix(
        client=client,
        lc_file=temporary_file,
        file_format=".csv"
    )
    temporary_file.close()

    response_data = response.json()
    assert response.status_code == 400
    assert response_data["Status"] == "Unsuccessful"
    assert len(response_data.keys()) == 4
    assert response_data[
               'ErrorMessage'] == "Service does not support file format : csv. The only supported format is 'json' for now."
