# service3/server.py

from fastapi import FastAPI

app = FastAPI()

@app.get("/service3")
async def read_root():
    return {"message": "Hello, World! from service3"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8003)