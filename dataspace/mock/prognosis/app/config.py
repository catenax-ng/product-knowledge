"""
    Config file provides the settings/configuration needed for that specific launched instance
"""
import os
from typing import List, Union

from pydantic import BaseSettings, Field


class BaseConf(BaseSettings):
    """
        Default parameters for all environments
    """
    API_PREFIX: str = "/api"
    VERSION: str = "1.0.0"
    DEBUG: bool = Field(
        default=True,
        description="To have the app run in development mode, "
                    "for features such as hot reload and others")
    PROJECT_NAME: str = Field(
        default="Remaining Useful Lifetime API",
        description="Signifies the project name. Shows up in the doc page")
    ALLOWED_HOSTS: List[str] = Field(
        default=[],
        description="To restrict requests coming from only few hosts or to allow"
                                                 " all by passing '*'")
    FILE_LOCATION: str = Field(
        default="files",
        description="Location where the upload files are initially stored and "
                    "then sent to dc service")
    DM_FILE: str = Field(default=os.path.join("files", "DamageMatrix_GearOil.json"),
                         description="Path to load the dm from.")


class DevConf(BaseConf):
    """
        Development environment config
    """
    DEBUG: bool = False
    FILE_LOCATION: str = "/tmp/files"
    BASE_API_URL = "http://localhost:5005"

# pylint: disable=unnecessary-ellipsis
class ProdConf(DevConf):
    """
        Production environment config
    """
    BASE_API_URL = "http://tiera-backend:5005"
    ...


class TestConf(BaseConf):
    """
        Testing environment config
    """
    FILE_LOCATION: str = "tests/tmp"


config = dict(
    local=BaseConf,
    dev=DevConf,
    prod=ProdConf,
    test=TestConf
)

settings: Union[BaseConf, DevConf, ProdConf] = config.get(
    os.getenv("SERVER_ENV", "local").lower())()
