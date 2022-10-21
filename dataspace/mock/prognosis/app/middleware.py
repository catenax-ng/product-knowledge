"""
    Contains custom middlewares for application
"""
from starlette.requests import Request
from starlette.responses import JSONResponse


async def catch_exceptions_middleware(request: Request, call_next):
    """
    Middleware to handle any unhandled exceptions in the service
    """
    try:
        return await call_next(request)
    except Exception:  # pylint: disable=broad-except
        # add logging here to show full stack trace
        return JSONResponse({
            "Status": "Unsuccessful",
            "ErrorMessage": "Internal Server Error",
            "RUL": {}
        }, status_code=500)
