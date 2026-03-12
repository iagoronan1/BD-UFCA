from database import SessionLocal
from models.hospede import Hospede

session = SessionLocal()

def criar_hospede(nome, documento, email):

    existente = session.query(Hospede).filter(
        Hospede.documento == documento
    ).first()

    if existente:
        print("Hospede com esse documento já existe")
        return

    hospede = Hospede(
        nome=nome,
        documento=documento,
        email=email
    )

    session.add(hospede)
    session.commit()

    print("Hospede criado com sucesso")


##---------------------------------------------##

def atualizar_email_hospede(id_hospede, novo_email):

    hospede = session.query(Hospede).filter(
        Hospede.id_hospede == id_hospede
    ).first()

    if hospede:
        hospede.email = novo_email
        session.commit()
        print("Email atualizado com sucesso")
    else:
        print("Hospede não encontrado")

##------------------------------------------------##

def deletar_hospede(id_hospede):

    hospede = session.query(Hospede).filter(
        Hospede.id_hospede == id_hospede
    ).first()

    if hospede:
        session.delete(hospede)
        session.commit()
        print("Hospede removido")
    else:
        print("Hospede não encontrado")

##--------------------------------------------------##

def listar_hospedes():

    hospedes = session.query(Hospede).all()

    for h in hospedes:
        print(
            h.id_hospede,
            h.nome,
            h.documento,
            h.email
        )

##-------------------------------------------------##

