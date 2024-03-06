from fastapi import FastAPI, WebSocket
import asyncio
import bson
import random

app = FastAPI()

@app.websocket("/ws")
async def data(websocket: WebSocket):
    await websocket.accept()

    while True:
        number = str(random.randint(0, 110))
        data = bson.dumps({"number": number})
        await websocket.send_bytes(data)
        await asyncio.sleep(0.2)
