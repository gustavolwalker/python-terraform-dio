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

| Method | Endpoint                 | Describe                     |
|--------| ------------------------ | -----------------------------|
| GET    | localhost:8000           | Return a list of tasks       |
| POST   | localhost:8000           | Add a new task and return it |
| PATCH  | localhost:8000/{task_id} | Edit a task and return it    |

### GET 

Call:
```shell
  http GET localhost:8000 
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

### POST

Call:
```shell
  http POST localhost:8000 msg="Hello APP"
```

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

Call:
```shell
  http PATCH localhost:8000/1 done=True 
```

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

## Deploy And Runing on AWS

In this sample we using OpenTofu (Fork of Terraform)

To deploy we need to inicializate and validate terraform files:

```shell
#Inicialize 
tofu init;

#Validate terraform files
tofu validate;
```

After validate we need to explain changes, for this using comand 'plan'

```shell
#Analyse deploy 
tofu plan;
```

After we need to apply our plan
```shell
#Apply deploy
tofu apply
```

After apply we need to connect in our account and copy the public ip addres of ec2 instance and database host in RDS.

Now we connect in our ec2 instance and install requirements packages
```shell
ssh ubuntu@<public id address ec2>;

sudo apt update;
sudo apt dist-upgrade;

sudo apt install python3-fastapi python3-uvicorn python3-psycopg2 python3-sqlmodel python3-pydantic;

exit;
```

After 'exit' we return to our machines and copy src files to ec2:
```shell
scp -r src/ ubuntu@<public id address ec2>:~/
```

Now we start our app:
```shell
ssh ubuntu@<public id address ec2>;

sudo DATABASE_HOST=<RDS database host> python3 -m uvicorn --app-dir src/ --host 0.0.0.0 --port 80 main:api \
```

In another console it's possible to test our app:
```shell
http GET <public id address ec2>

http POST <public id address ec2> msg="Test AWS"

http PATCH <public id address ec2>/1 done=True
```

After all we need to destroy this test, first disconect from ec2 and running destroy command:
```shell
#Destroy deploy
tofu destroy
```
