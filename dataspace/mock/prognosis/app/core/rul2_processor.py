"""
File contains the core logic which would power the new RUL resource.
"""
import logging
import json
from datetime import datetime
import random
import httpx

from app.utils.exceptions import CustomException

LOGGER = logging.getLogger("RUL2")

class Rul2Service:
    """ This class supports RUL resource with needed functionalities. """

    def __init__(self, notification) -> None:
        """
        Constructor for RUL2Service class

        Args:
            notification: incoming notification
        """

        self.notification = notification
        self.header = notification.get('header')
        if not self.header:
            raise CustomException(
                error_message=f"RUL Input "
                              f"does not have header which is mandatory.",
                metadata=self.notification
             )
        self.notificationID = self.header.get('notificationID')
        if not self.notificationID:
            raise CustomException(
                error_message=f"RUL Input Header "
                              f"does not have notificationID which is mandatory.",
                metadata=self.header
             )
        self.respondAssetId = self.header.get('respondAssetId')
        if not self.respondAssetId:
            raise CustomException(
                error_message=f"RUL Input Header"
                              f"does not have respondAssetId which is mandatory.",
                metadata=self.header
             )
        self.content = notification.get('content')
        if not self.content:
            raise CustomException(
                error_message=f"RUL Input "
                              f"does not have content which is mandatory.",
                metadata=self.notification
             )
        self.requestRefId = self.content.get('requestRefId')
        if not self.requestRefId:
            raise CustomException(
                error_message=f"RUL Input Content"
                              f"does not have requestRefId which is mandatory.",
                metadata=self.content
             )

        errors = self.validate()

        if errors:
            LOGGER.warning(f"RUL produced errors {errors}.")
            raise CustomException(
                error_message=f"RUL Input does not have "
                              f"{','.join(errors)} information which are mandatory.",
                metadata=self.notification
            )

        LOGGER.info("RUL passed all the validations")

    def validate(self) -> list:
        """
        This method takes care of checking validations on uploaded rul content.
        If any validation fails, then throws 400 status code response with ErrorMessage.

        Returns: error if not raise CustomException with error message

        Raises:
            CustomException: If any validation fail will raise custom exception
        """

        LOGGER.info(f"Validating RUL for notification {self.requestRefId}.")

        errors = []
        endurancePredictorInputs = self.content['endurancePredictorInputs']
        if not endurancePredictorInputs:
            raise CustomException(
                error_message=f"RUL content does not have "
                              f"endurancePredictorInputs which is mandatory.",
                            metadata=self.requestRefId
                        )

        for input in endurancePredictorInputs:
            componentId = input.get('componentId')
            if not componentId:
                raise CustomException(
                    error_message=f"RUL content input does not have "
                              f"componentId which is mandatory.",
                            metadata=self.input
                        )
            gearOil = input['classifiedLoadSpectrumGearOil']
            gearSet = input['classifiedLoadSpectrumGearSet']

            if (not gearOil) | (not gearSet):
                raise CustomException(
                    error_message=f"RUL content input must have either "
                              f"classifiedLoadSpectrumGearOil or  classifiedLoadSpectrumGearSet.",
                            metadata=self.input
                        )
            
            errors=[]

            if gearOil:
                errors = errors + self.validateLoadCollective(gearOil)
            
            if gearSet:
                errors = errors + self.validateLoadCollective(gearSet)

            return errors

    def validateLoadCollective(self, classifiedLoadCollective) -> list: 
        errors=[]

        header = classifiedLoadCollective.get("header")
        if not header:
            raise CustomException(
                 error_message=f"Health Indicator Input does not have "
                               f"classifiedLoadCollective.header which is mandatory.",
                               metadata=self.hi_component
                 )

        channels = header.get("channels")
        if (not channels or not isinstance(channels, list)):
            raise CustomException(
                 error_message=f"Health Indicator Input does not have a "
                               f"classifiedLoadCollective.header.channels array which is mandatory.",
                              metadata=self.hi_component
            )
        channelsCount = len(channels)

        body = classifiedLoadCollective.get("body")
        if not body:
            raise CustomException(
                 error_message=f"Health Indicator Input does not have "
                               f"classifiedLoadCollective.body which is mandatory.",
                               metadata=self.hi_component
                 )

        counts = body.get("counts")
        if not counts:
            raise CustomException(
                 error_message=f"Health Indicator Input does not have "
                               f"classifiedLoadCollective.body.counts which is mandatory.",
                               metadata=self.hi_component
                 )

        countsList = counts.get("countsList")
        if (not countsList or not isinstance(countsList, list)):
            raise CustomException(
                 error_message=f"Health Indicator Input does not have "
                               f"classifiedLoadCollective.body.counts.countsList array which is mandatory.",
                               metadata=self.hi_component
                 )
        countsListCount = len(countsList)

        LOGGER.info(f"Got {countsListCount} counts.")

        classes = body.get("classes")
        if (not classes or not isinstance(classes, list)):
            raise CustomException(
                 error_message=f"Health Indicator Input does not have "
                               f"classifiedLoadCollective.body.classes array which is mandatory.",
                               metadata=self.hi_component
                 )

        classesCount= len(classes)

        if (channelsCount!=classesCount):
            errors.append(f"{channelsCount} channels, but {classesCount} classes")

        for clazz in classes:

            className = clazz.get("className")
            if not className:
               errors.append(f"A class has no name which is mandatory")

            classList = clazz.get("classList")
            if (not classList or not isinstance(classList, list)):
              errors.append(f"Class {className} has no classList array which is mandatory")
            else:
              classListCount=len(classList)

              LOGGER.info(f"Got {classListCount} classes for class {className}.")

              if (classListCount!=countsListCount):
                errors.append(f"Class {className} has {classListCount} entries, but there are {countsListCount} counts.")

        return errors

    def compute_predictor(self,input):
        random.seed(hash(json.dumps(input,sort_keys=True)))
        result=  {
                        "componentId": input.get('componentId'),
                        "componentType": "GearBox",
                        "remainingUsefulLife": {
                            "remainingOperatingHours": round(random.random()*50000.0)/10.0,
                            "remainingRunningDistance":  round(random.random()*300000.0),
                            "determinationLoaddataSource": {
                                "informationOriginLoadSpectrum": "loggedOEM",
                                "informationLoadSpectrum": "loggedOEM"
                            } ,
                            "determinationStatus": {
                                "date": "2023-02-19T09:42:14.213Z",
                                "operatingHours": round(random.random()*1000000.0)/10.0,
                                "mileage": round(random.random()*6000000.0)
                            },
                            "bammId": "urn:bamm:io.catenax.rul:1.0.0##RemainingUsefulLife"
                        }
                }
        return result
    
    def mock_response(self):
        """
        This method is used to get mock response
        
        Returns: result is a mock response

        """

        result = {
            "timestamp": "2024-02-06T15:03:00.837774424Z",
            "result": "Ok",
            "message": "Accepted."
        }

        responseHeader = self.notification.get('header')
        responseHeader['referencedNotificationID']=responseHeader['notificationID']
        response = {
            "header": responseHeader,
            "content": {
                "requestRefId": self.requestRefId,
                "componentType": "GearBox",
                "endurancePredictorOutputs": list(map(self.compute_predictor,self.content.get('endurancePredictorInputs')))
            }
        }

        LOGGER.debug(response)

        with httpx.Client() as client:
            webhook_response = client.post(self.respondAssetId,json=response)
            LOGGER.debug(webhook_response)

        return result
