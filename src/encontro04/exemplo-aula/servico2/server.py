from fastapi import FastAPI

app = FastAPI()

@app.get("/service2")
async def read_root():
    return {"message": "Hello, World! from service2"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8002)