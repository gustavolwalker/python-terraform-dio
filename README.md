# Python + Terraform 
This is a sample app developed during the curse "Infrastruture as Code with Terraform and Python" by DIO

## Technologies

- Python: 3.11
  - FastAPI
  - Uvicorn

## File Structure

- src: The source code folder
- README.md: This file

## Run localy 

Dependencies:
- Python 3
- http 

### Python 

First install requirements using a Virtual enviroment

```shell
python3 -m venv .venv;

source .venv/bin/activate

pip install fastapi uvicorn
```

Sample code (src/main.py)
```python   
from fastapi import FastAPI

api = FastAPI()

@api.get("/")
def index():
    return "Hello World" 
```

Run sample code:
```shell
uvicorn --app-dir src/ --host 0.0.0.0 --port 8000 --reload main:api
```

Test sample code:
```shell
http localhost:8000
```

Output test sample code:
```shell
HTTP/1.1 200 OK
content-length: 13
content-type: application/json
date: Sat, 25 May 2024 20:53:05 GMT
server: uvicorn

"Hello World"
```