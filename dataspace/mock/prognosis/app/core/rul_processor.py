"""
File contains the core logic which would power RUL resource.
"""
import logging
from datetime import datetime

from app.utils.exceptions import CustomException

LOGGER = logging.getLogger("RUL")

class RulService:
    """ This class supports RUL resource with needed functionalities. """

    def __init__(self, lc_data: dict, lc_filename: str) -> None:
        """
        Constructor for RulService class

        Args:
            lc_data: Load Collective data loaded from uploaded file
            lc_filename: Load Collective Filename
        """

        self.lc_data = lc_data
        self.lc_filename = lc_filename

        errors = self.validate()
        self.lc_metadata = lc_data.get("Metadata")
        if errors:
            raise CustomException(
                error_message=f"LoadCollectiveFile '{lc_filename}' Metadata does not have "
                              f"{','.join(errors)} information which are mandatory.",
                metadata=self.lc_metadata
            )

        LOGGER.info("Load Collective file passed all the validations")

    def validate(self) -> list:
        """
        This method takes care of checking validations on uploaded load collective file.
        If any validation fails, then throws 400 status code response with ErrorMessage.

        Returns: error if not raise CustomException with error message

        Raises:
            CustomException: If any validation fail will raise custom exception
        """

        errors = []
        if not self.lc_data.get("Metadata"):
            raise CustomException(
                error_message=f"LoadCollectiveFile '{self.lc_filename}' "
                              f"does not have metadata information which is mandatory.",
                metadata=self.lc_data.get("Metadata"))

        for meta_field in ["Component", "RegistrationDate", "Mileage"]:
            if not self.lc_data["Metadata"].get(meta_field):
                errors.append(f"{meta_field}")

            if isinstance(self.lc_data["Metadata"].get(meta_field), dict):
                missing_fields = [sub_field for sub_field in ["Value", "Unit"] if
                                  not self.lc_data["Metadata"][meta_field].get(sub_field)]
                if missing_fields:
                    errors.append(f"{meta_field} - {','.join(missing_fields)}")

        if not errors:
            mileage_value = int(self.lc_data["Metadata"]["Mileage"]["Value"])
            if mileage_value < 0:
                raise CustomException(
                    error_message="Mileage value in Load Collective has to be mandatory positive.",
                    metadata=self.lc_data.get("Metadata")
                )

            registered_date = self.lc_data["Metadata"]["RegistrationDate"]["Value"]
            try:
                _ = datetime.strptime(str(registered_date), "%Y%m%d")
            except (ValueError, SyntaxError) as err:
                LOGGER.exception("Converting registered date from string to object "
                                 "failed with error : %s", err)
                raise CustomException(
                    error_message="Registered date should be in the format of yyyymmdd",
                    metadata=self.lc_data.get("Metadata")
                )

        return errors

    def mock_response(self):
        """
        This method is used to get mock response
        
        Returns: result is a mock response

        """
        result = {
            "RUL": {
                "remainingDistance": {
                        "Value": 150,
                        "Unit": "km"
                    },
                "remainingTime": {
                        "Value": 2,
                        "Unit": "years"
                    }
            }
        }
        return result
