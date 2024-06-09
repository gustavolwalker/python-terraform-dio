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

#### Install requirements

First install requirements using a Virtual enviroment

```shell
python3 -m venv .venv;

source .venv/bin/activate

pip install fastapi uvicorn
```

#### Sample code (src/main.py)
```python   
from fastapi import FastAPI

api = FastAPI()

@api.get("/")
def index():
    return "Hello World" 
```

#### Run sample code:
```shell
uvicorn --app-dir src/ --host 0.0.0.0 --port 8000 --reload main:api
```

#### Test sample code:
```shell
http GET localhost:8000
```

#### Output test sample code:
```shell
HTTP/1.1 200 OK
content-length: 13
content-type: application/json
date: Sat, 25 May 2024 20:53:05 GMT
server: uvicorn

"Hello World"
```

### Docker 

#### Build 

```shell
docker build -t asdf . 
```

#### Test (Run bash in interactive mode)

```shell
docker run -it --entrypoint bash asdf
```

#### Test (Run python in interactive mode)

```shell
docker run -it --entrypoint python asdf
```

#### Run and Test

Run:
```shell
docker run -p 8000:8000 asdf
```

Test sample code:
```shell
http GET localhost:8000
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

### Docker Compose

#### Run and Test

Run:
```shell
docker compose up
```

Test sample code:
```shell
http GET localhost:8000
```

Output test sample code:
```shell
HTTP/1.1 200 OK
content-length: 58
content-type: application/json
date: Sun, 09 Jun 2024 22:06:04 GMT
server: uvicorn

"UUID from Postgres: 3a229dc4-c8f5-4429-86f4-bf10e3c3f9b4"
```

#### Access database PostgreSQL

```shell
docker compose exec db psql -U postgres
```

## API Implement

| Method | Endpoint                 | Call example                             |
|--------| ------------------------ | -----------------------------------------|
| GET    | localhost:8000           | http GET localhost:8000                  |
| POST   | localhost:8000           | http POST localhost:8000 msg="Hello APP" |
| PATCH  | localhost:8000/{task_id} | http GET localhost:8000/1 done=True      |

### GET 
Return example:
```json
[
    {
        "id": 1,
        "msg": "Hello, dio",
        "done": false
    }
]

```

### POST
Body example: 
```json
{
    "msg": "Hello, dio",
}
```

Return example:
```json
[
    {
        "id": 1,
        "msg": "Hello, dio",
        "done": false
    }
]

```

### PATCH
Body example: 
```json
{
    "done": true,
}
```

Return example:
```json
[
    {
        "id": 1,
        "msg": "Hello, dio",
        "done": true
    }
]

```