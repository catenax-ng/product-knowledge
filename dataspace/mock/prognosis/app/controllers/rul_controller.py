""" This file will handle the request of RUL"""
import json
import logging
from typing import Optional

from app.core.rul_processor import RulService
from app.utils.docs import CALCULATION_RUL_DESCRIPTION
from app.utils.exceptions import CustomException
from fastapi import APIRouter, File, UploadFile
from fastapi.responses import JSONResponse

router = APIRouter()
LOGGER = logging.getLogger("RUL")


@router.post("/rul", description=CALCULATION_RUL_DESCRIPTION,
             summary="Calculating The Remaining Useful Life Of A Component")
async def perform_calculation(load_collective_file: Optional[UploadFile] = File(...)):
    """
    This method is used to perform calculation and give remaining useful life
    Args:
        load_collective_file: load collective file

    Returns: Response of remaining useful life params

    Raises:
        CustomException: if any exception will handle this exception
    """

    file_format = load_collective_file.filename.split(".")[-1]
    if file_format != "json":
        raise CustomException(
            error_message=f"Service does not support file format : {file_format}. "
                          f"The only supported format is 'json' for now.",
        )

    load_collective_bytes = await load_collective_file.read()
    load_collective_data = json.loads(load_collective_bytes)

    rul_obj = RulService(lc_data=load_collective_data, lc_filename=load_collective_file.filename)
    damage_calc_data_result = rul_obj.mock_response()

    LOGGER.info("Retrieving fields needed for performing calculations")
    metadata = load_collective_data["Metadata"]
    LOGGER.info("Generate result data for the component")

    return JSONResponse({
        "Status": "Successful",
        "Metadata": metadata,
        "RUL": damage_calc_data_result
    })
