from sqlalchemy import Column, Integer, String, Numeric
from database import Base

class Quarto(Base):

    __tablename__ = "quartos"

    id_quarto = Column(Integer, primary_key=True, index=True)
    numero = Column(Integer)
    tipo = Column(String)
    capacidade = Column(Integer)
    tarifa_base = Column(Numeric)
    status = Column(String)