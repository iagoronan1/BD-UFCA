from database import SessionLocal
from models.reserva import Reserva
from models.hospede import Hospede
from models.quarto import Quarto

session = SessionLocal()


def reservas_com_hospede():

    reservas = session.query(Reserva).join(Hospede).all()

    for r in reservas:
        print(r.id_reserva, r.hospede.nome)


def reservas_com_quarto():

    reservas = session.query(Reserva).join(Quarto).all()

    for r in reservas:
        print(r.id_reserva, r.quarto.numero)

##-----------------------------------------##

def reservas_com_hospede():

    reservas = session.query(Reserva).join(Hospede).all()

    for r in reservas:
        print(
            r.id_reserva,
            r.hospede.nome,
            r.data_entrada,
            r.data_saida
        )

##-------------------------------------------##

def reservas_com_quarto():

    reservas = session.query(Reserva).join(Quarto).all()

    for r in reservas:
        print(
            r.id_reserva,
            r.quarto.numero,
            r.status
        )

##---------------------------------------------##

def reservas_confirmadas():

    reservas = session.query(Reserva)\
        .filter(Reserva.status == "CONFIRMADA")\
        .order_by(Reserva.data_entrada).all()

    for r in reservas:
        print(
            r.id_reserva,
            r.status,
            r.data_entrada
        )

##-----------------------------------------------##

