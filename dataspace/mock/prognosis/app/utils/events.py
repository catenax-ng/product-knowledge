"""
Events are defined in this function to perform actions at either start or stop of application
Example:
    Connecting to Database while the application starts
    Initializing logger instance
"""
from typing import Callable

from .logging import setup_logger_singleton


def create_start_app_handler() -> Callable:
    """
        Responsible for initializing logger instance at start of application
    """
    def start_app() -> None:
        setup_logger_singleton()
    return start_app
