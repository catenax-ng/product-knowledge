""" This file is used for unittest of new RUL service"""
import copy
import json
import os
import tempfile
import logging

from app.utils.exceptions import CustomException

import pytest
import httpx

THIS_FOLDER = os.path.dirname(os.path.abspath(__file__))
LOGGER = logging.getLogger("HI2_TEST")

def hi_request(client, hi_data):
    """
    Utility function to perform rest request
    Args:
        client:
        hi_data:

    Returns:

    """
    return client.post(
        '/api/hi2',
        json=hi_data
    )

def web_hook(): return 'https://webhook.site/3332d1f8-3fec-4223-8add-004583ba72d3'
def web_hook_request(): return 'https://webhook.site/token/3332d1f8-3fec-4223-8add-004583ba72d3/request/latest/raw'
def web_hook_delete_request(): return 'https://webhook.site/token/3332d1f8-3fec-4223-8add-004583ba72d3/request'

def hi_data(): 
    hi_data = {
        "header": {
        "notificationID": "98f507d5-175d-4945-8d06-6aa1fcef9a0c",
        "senderBPN": "BPN0000SUPPLIER",
        "senderAddress": "edcs://supplier.com/edc",
        "recipientAddress": "https://supplier.com/edc",
        "recipientBPN": "BPN0000SUPPLIER",
        "severity": "MINOR",
        "status": "SENT",
        "targetDate": "2022-11-24T22:07:02.611048800Z",
        "timeStamp": "2022-11-24T11:24:36.744320Z",
        "classification": "HealthIndicationPredictor",
        "respondAssetId": web_hook()
        },
        "content": {
        "requestRefId": "98f507d5-175d-4945-8d06-6aa1fcef9a0c",
        "endurancePredictorInputs": [
            {
            "componentId": "urn:uuid:b43a1fab-f460-4d24-b078-e58a0247ad1e",
            "classifiedLoadSpectrumClutch": {
                "targetComponentID": "urn:uuid:b43a1fab-f460-4d24-b078-e58a0247ad1e",
                "metadata": {
                "projectDescription": "pnr_76543",
                "componentDescription": "Clutch",
                "routeDescription": "logged",
                "status": {
                    "date": "2023-02-19T10:42:14.213+01:00",
                    "operatingHours": 32137.9,
                    "mileage": 865432
                }
                },
                "header": {
                "countingValue": "Time",
                "countingUnit": "unit:secondUnitOfTime",
                "countingMethod": "TimeAtLevel",
                "channels": [
                    {
                    "channelName": "TC_SU",
                    "unit": "unit:degreeCelsius",
                    "lowerLimit": 0,
                    "upperLimit": 640,
                    "numberOfBins": 128
                    }
                ]
                },
                "body": {
                "classes": [
                    {
                    "className": "TC_SU-class",
                    "classList": [
                        14,
                        15,
                        16,
                        17,
                        18,
                        19,
                        20,
                        21,
                        22
                    ]
                    }
                ],
                "counts": {
                    "countsName": "Time",
                    "countsList": [
                    34968.93,
                    739782.51,
                    4013185.15,
                    46755055.56,
                    25268958.35,
                    8649735.95,
                    9383635.35,
                    19189260.77,
                    1353867.54
                    ]
                }
                },
                "bammId": "urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadSpectrum"
            }
            }
        ]
        }
    }
    return hi_data
    
def test_hi(client):
    """

    Args:
        client:
        
    Returns:

    """
    
    with httpx.Client() as otherClient:
        otherClient.delete(web_hook_delete_request())

    response = hi_request(
        client=client,
        hi_data=hi_data()
    )

    LOGGER.info(response)
    response_data = response.json()
    assert response.status_code == 200
    assert response_data["message"] == "Accepted."
    assert response_data["result"] == "Ok"

    with httpx.Client() as otherClient:
        webhook = otherClient.get(web_hook_request())
        
    LOGGER.info(webhook.json())
