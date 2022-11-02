"""
File contains the core logic which would power HI resource.
"""
import logging
from datetime import datetime

from app.utils.exceptions import CustomException

LOGGER = logging.getLogger("HI")

class HiService:
    """ This class supports HI resource with needed functionalities. """

    def __init__(self, hi_data: dict, hi_filename: str) -> None:
        """
        Constructor for HiService class

        Args:
            hi_data: Load Collective & adaption data loaded from uploaded file
            hi_filename: request id 
        """

        self.hi_data = hi_data
        self.hi_filename = hi_filename

        errors = self.validate()
        self.hi_component = hi_data.get("componentId")
        if errors:
            raise CustomException(
                error_message=f"Health Indicator Input '{hi_filename}' Component '{componentId}' does not have "
                              f"{','.join(errors)} information which are mandatory.",
                metadata=self.hi_component
            )

        LOGGER.info("Health indicator file passed all the validations")

    def validate(self) -> list:
        """
        This method takes care of checking validations on uploaded hi file.
        If any validation fails, then throws 400 status code response with ErrorMessage.

        Returns: error if not raise CustomException with error message

        Raises:
            CustomException: If any validation fail will raise custom exception
        """

        errors = []
        if not self.hi_data.get("componentId"):
            raise CustomException(
                error_message=f"Health Indicator Input '{self.hi_filename}' "
                              f"does not have metadata information which is mandatory.",
                metadata=self.hi_filename
            )
            
        for meta_field in ["classifiedLoadCollective", "adaptionValueList"]:
            if not self.hi_data.get(meta_field):
                errors.append(f"{meta_field}")

        return errors

    def mock_response(self):
        """
        This method is used to get mock response
        
        Returns: result is a mock response

        """
        result = {
			"version" : "VER_AV_001",
			"componentId" : self.hi_component,
			"healthIndicatorValues" : [0.5] 	
		}
        return result
