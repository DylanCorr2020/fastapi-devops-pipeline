

from fastapi import FastAPI, HTTPException 
from fastapi.responses import JSONResponse

app = FastAPI()

# returns hello world object when someone vists / endpoint 
@app.get("/")
def root():
    return{"Hello": "World"}


#Basic health check endpoint 
@app.get("/health")
async def get_health():
    return JSONResponse (
        content = {"status" : 200},
        status_code = 200
    )

    





