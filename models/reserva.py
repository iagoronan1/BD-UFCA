<<<<<<< HEAD
from sqlalchemy import Column, Integer, String, Date, Numeric, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class Reserva(Base):

    __tablename__ = "reservas"

    id_reserva = Column(Integer, primary_key=True, index=True)

    id_hospede = Column(Integer, ForeignKey("hospedes.id_hospede"))
    id_quarto = Column(Integer, ForeignKey("quartos.id_quarto"))

    data_entrada = Column(Date)
    data_saida = Column(Date)

    numero_hospedes = Column(Integer)
    origem = Column(String)
    status = Column(String)

    valor_total = Column(Numeric)

    hospede = relationship("Hospede")
=======
from sqlalchemy import Column, Integer, String, Date, Numeric, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class Reserva(Base):

    __tablename__ = "reservas"

    id_reserva = Column(Integer, primary_key=True, index=True)

    id_hospede = Column(Integer, ForeignKey("hospedes.id_hospede"))
    id_quarto = Column(Integer, ForeignKey("quartos.id_quarto"))

    data_entrada = Column(Date)
    data_saida = Column(Date)

    numero_hospedes = Column(Integer)
    origem = Column(String)
    status = Column(String)

    valor_total = Column(Numeric)

    hospede = relationship("Hospede")
>>>>>>> 001448c0521ec805a4b6bc80b5ab1c80f4c78714
    quarto = relationship("Quarto")