<<<<<<< HEAD
from sqlalchemy import Column, Integer, String
from database import Base

class Hospede(Base):

    __tablename__ = "hospedes"

    id_hospede = Column(Integer, primary_key=True, index=True)
    nome = Column(String)
    documento = Column(String)
    email = Column(String)
=======
from sqlalchemy import Column, Integer, String
from database import Base

class Hospede(Base):

    __tablename__ = "hospedes"

    id_hospede = Column(Integer, primary_key=True, index=True)
    nome = Column(String)
    documento = Column(String)
    email = Column(String)
>>>>>>> 001448c0521ec805a4b6bc80b5ab1c80f4c78714
    telefone = Column(String)