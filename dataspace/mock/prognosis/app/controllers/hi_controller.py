""" This file will handle the request of HI"""
import json
import logging
from typing import Optional

from app.core.hi_processor import HiService
from app.utils.docs import CALCULATION_HI_DESCRIPTION
from app.utils.exceptions import CustomException
from fastapi import APIRouter, File, UploadFile
from fastapi.responses import JSONResponse

router = APIRouter()
LOGGER = logging.getLogger("HI")


@router.post("/hi", description=CALCULATION_HI_DESCRIPTION,
             summary="Calculating The Health Indicator Of A Vehicle/Component")
async def perform_calculation(hi_input: Optional[UploadFile] = File(...)):
    """
    This method is used to perform calculation and give health indicator
    Args:
        hi_input: request input file

    Returns: Response of health indicator params

    Raises:
        CustomException: if any exception will handle this exception
    """

    file_format = hi_input.filename.split(".")[-1]
    if file_format != "json":
        raise CustomException(
            error_message=f"Service does not support file format : {file_format}. "
                          f"The only supported format is 'json' for now.",
        )

    hi_input_bytes = await hi_input.read()
    hi_input_data = json.loads(hi_input_bytes)

    LOGGER.info("Got a hi service request with input data '{hi_input_data}'")
    
    hi_input_id=hi_input_data.get("requestRefId")
    hi_input_each=hi_input_data.get("healthIndicatorInputs")

    hi_output_each = []
    for hi_input in hi_input_each:
        hi_obj = HiService(hi_data=hi_input, hi_filename=hi_input_id)
        hi_output_each.append(hi_obj.mock_response())

    return JSONResponse({
	  "requestRefId" : hi_input_id,
	  "healthIndicatorOutputs" : hi_output_each
    })
