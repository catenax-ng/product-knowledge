""" This file will handle the request of HI"""
import json
import logging
from typing import Optional

from app.core.rul2_processor import Rul2Service
from app.utils.docs import CALCULATION_HI_DESCRIPTION
from app.utils.exceptions import CustomException
from fastapi import APIRouter,  Request, HTTPException
from fastapi.responses import JSONResponse
from json import JSONDecodeError

router = APIRouter()
LOGGER = logging.getLogger("RUL2")


@router.post("/rul2", description=CALCULATION_HI_DESCRIPTION,
             summary="Calculating The Remaining Useful Life Of A Vehicle/Component")
async def perform_calculation(request: Request):
    """
    This method is used to perform calculation and give health indicator
    Args:
        request: proper json body

    Returns: Response of health indicator params

    Raises:
        CustomException: if any exception will handle this exception
    """
    content_type = request.headers.get('Content-Type')
    
    if content_type is None:
        raise HTTPException(status_code=400, detail='No Content-Type provided')
    elif content_type == 'application/json':
        try:
            rul_input_data = await request.json()
            LOGGER.debug("Got RUL input data "+str(rul_input_data))
            rul_obj = Rul2Service(notification=rul_input_data)
            LOGGER.debug("Setup RUL service "+str(rul_obj))
            return JSONResponse(rul_obj.mock_response())
        except JSONDecodeError:
            raise HTTPException(status_code=400, detail='Invalid JSON data')
        except Exception as e:
            LOGGER.warn(e)
            raise e
    else:
        raise HTTPException(status_code=400, detail='Content-Type not supported')
        
