""" Contains custom exception schema for application"""
from fastapi import Request
from fastapi.responses import JSONResponse


class CustomException(Exception):
    """
        Exception with custom schema to have a uniformity throughout application
    """

    # pylint: disable=super-init-not-called
    def __init__(self, error_message: str, metadata: dict = {}, status_code: int = 400) -> None:
        """

        Args:
            error_message:
            metadata:
            status_code:
        """
        self.payload = {
            "Status": "Unsuccessful",
            "ErrorMessage": error_message,
            "Metadata": metadata,
            "RUL": {}
        }
        self.status_code = status_code


# pylint: disable=unused-argument
async def custom_exception_handler(request: Request, exc: CustomException):
    """

    Args:
        request:
        exc:

    Returns:

    """
    return JSONResponse(content=exc.payload, status_code=exc.status_code)
