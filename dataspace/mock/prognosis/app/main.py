"""
    This file contains function which provides application instance
"""
from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

from app.config import settings
from app.controllers.blueprint import router as api_router
from app.middleware import catch_exceptions_middleware
from app.utils.events import create_start_app_handler
from app.utils.exceptions import CustomException, custom_exception_handler


def get_application() -> FastAPI:
    """
    This method is used to get application

    Returns: application

    """
    application = FastAPI(title=settings.PROJECT_NAME,
                          debug=settings.DEBUG, version=settings.VERSION)

    application.add_middleware(
        CORSMiddleware,
        allow_origins=settings.ALLOWED_HOSTS or ["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    application.add_event_handler("startup", create_start_app_handler())
    application.include_router(api_router, tags=["Remaining Useful Life"],
                               prefix=settings.API_PREFIX)
    application.exception_handler(CustomException)(custom_exception_handler)
    application.middleware('http')(catch_exceptions_middleware)

    return application
