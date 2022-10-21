import uvicorn

from app.main import get_application
from app.config import settings

app = get_application()


def run():
    """
    This function acts as a utility to run the app in development mode
    """
    uvicorn.run(
        "run:app",
        host="0.0.0.0",
        reload=True,
        port=5005,
        debug=settings.DEBUG
    )


if __name__ == '__main__':
    # Running the application
    run()
