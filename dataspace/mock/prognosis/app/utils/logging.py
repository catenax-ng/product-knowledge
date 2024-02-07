"""
    File contains global logger across all the modules.
"""

import logging

def setup_logger_singleton():
    """
    Function responsible for initializing logger instance to be used throughout app
    """

    formatter = logging.Formatter(
        '%(asctime)s [%(filename)-20s:%(funcName)-21s:%(lineno)-5s] [%(levelname)s] >> %(message)s')
    stream_handler = logging.StreamHandler()
    stream_handler.setFormatter(formatter)
    stream_handler.setLevel(logging.DEBUG)
    logger = logging.getLogger(name="RUL")
    logger.setLevel(logging.DEBUG)
    logger.addHandler(stream_handler)
    logger = logging.getLogger(name="RUL2")
    logger.setLevel(logging.DEBUG)
    logger.addHandler(stream_handler)
    logger = logging.getLogger(name="HI")
    logger.setLevel(logging.DEBUG)
    logger.addHandler(stream_handler)
