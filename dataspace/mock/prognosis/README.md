<h1 align="center">Mock Remaining Useful Life</h1>

# Introduction 
This is a mock service implementing the Cathena-X RUL interface.

## Installation
Below are the steps for installing and setting up the project.

```
sudo conda env create -f environment.yaml
conda activate rul
```

## Software Pre-requisites
Below are the software dependences

- Python3.8

# Build and Test

### Development Build
For running the application locally/development env, [Installation](#installation) and [Software dependencies](#software-pre-requisites) are pre-requisites

```
    python run.py
```

### Testing
[Pytest](https://docs.pytest.org/en/6.2.x/contents.html) module has been used for writing unittests in this app, do run the below command from app root directory
```
    pytest
```

### Interacting

````
curl --location --request POST 'http://localhost:5005/api/rul' \
--form 'load_collective_file=@"tests/data/Fzg1_LCollective.json"'
```

# Deploy 

1. Build docker
   ```
    docker build -t ghcr.io/catenax-ng/product-knowledge/backend/rul-mock:0.6.1-SNAPSHOT .
   ```

2. Run docker
   ```
    docker run -p5005:5005 ghcr.io/catenax-ng/product-knowledge/backend/rul-mock:0.6.1-SNAPSHOT
   ```
