

from fastapi import FastAPI, HTTPException 
from fastapi.responses import JSONResponse

app = FastAPI()

# returns hello world object when someone vists / endpoint 
@app.get("/")
def root():
    return{"API is running"}


#Basic health check endpoint 
@app.get("/health")
async def get_health():
    return JSONResponse (
        content = {"status" : 200},
        status_code = 200
    )

#Return message 
@app.get("/message")
async def get_message():
    return {"Hello Dylan"}


@app.get("/demo")
async def demo():
    return {"message": "CI/CD pipeline working"}






