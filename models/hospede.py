from sqlalchemy import Column, Integer, String
from database import Base

class Hospede(Base):

    __tablename__ = "hospedes"

    id_hospede = Column(Integer, primary_key=True, index=True)
    nome = Column(String)
    documento = Column(String)
    email = Column(String)
    telefone = Column(String)