<<<<<<< HEAD
from sqlalchemy import Column, Integer, String, Numeric
from database import Base

class Quarto(Base):

    __tablename__ = "quartos"

    id_quarto = Column(Integer, primary_key=True, index=True)
    numero = Column(Integer)
    tipo = Column(String)
    capacidade = Column(Integer)
    tarifa_base = Column(Numeric)
=======
from sqlalchemy import Column, Integer, String, Numeric
from database import Base

class Quarto(Base):

    __tablename__ = "quartos"

    id_quarto = Column(Integer, primary_key=True, index=True)
    numero = Column(Integer)
    tipo = Column(String)
    capacidade = Column(Integer)
    tarifa_base = Column(Numeric)
>>>>>>> 001448c0521ec805a4b6bc80b5ab1c80f4c78714
    status = Column(String)