from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker, declarative_base
import os

if os.getenv("TESTING"):
    DATABASE_URL = "postgresql+psycopg://test:test@localhost:5432/testdb"
else:
    DATABASE_URL = "postgresql+psycopg://kubsu:kubsu@127.0.0.1:5432/kubsu"


engine = create_async_engine(DATABASE_URL, echo=True)
AsyncSessionLocal = sessionmaker(bind=engine, class_=AsyncSession, expire_on_commit=False)
Base = declarative_base()


async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)


async def get_db() -> AsyncSession:
    async with AsyncSessionLocal() as session:
        yield session
