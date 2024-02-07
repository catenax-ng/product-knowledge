""" This file will route the http request to respective method
 which will handle business logic"""
from app.controllers import rul_controller, hi_controller, rul2_controller, hi2_controller
from fastapi import APIRouter

router = APIRouter()

router.include_router(rul_controller.router)
router.include_router(hi_controller.router)
router.include_router(rul2_controller.router)
router.include_router(hi2_controller.router)
