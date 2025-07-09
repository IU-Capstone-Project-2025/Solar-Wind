import asyncio
import logging
import sys
from os import getenv
from random import randint

import requests
from aiogram import Bot, Dispatcher, html
from aiogram.client.default import DefaultBotProperties
from aiogram.enums import ParseMode
from aiogram.filters import CommandStart
from aiogram.types import Message

TOKEN = getenv("TELEGRAM_BOT_TOKEN")

dp = Dispatcher()


@dp.message(CommandStart())
async def command_start_handler(message: Message) -> None:
    code = f"{randint(0, 10000):04d}"
    requests.post(
        f"{getenv('PROFILES_URL')}/custom-auth",
        params={"code": f"{code}", "userId": message.from_user.id},
        headers={"Authorize": TOKEN},
    )
    await message.answer(f"Your code is ||`{code}`||. Do not pass it to anybody, and use **only** to authenticate in Solar-Wind app")


async def main() -> None:
    bot = Bot(token=TOKEN, default=DefaultBotProperties(parse_mode=ParseMode.HTML))
    await dp.start_polling(bot)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, stream=sys.stdout)
    asyncio.run(main())