<<<<<<< HEAD
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

DATABASE_URL = "postgresql+psycopg2://postgres:123@localhost:5432/hotel"

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(bind=engine)

=======
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

DATABASE_URL = "postgresql+psycopg2://postgres:123@localhost:5432/hotel"

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(bind=engine)

>>>>>>> 001448c0521ec805a4b6bc80b5ab1c80f4c78714
Base = declarative_base()