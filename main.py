from crud import criar_hospede, listar_hospedes
from queries import reservas_com_hospede, reservas_com_quarto

def main():

    print("Criando hospede...")
    criar_hospede(
        "João Silva",
        "123456",
        "joao@email.com"
    )

    print("Listando hospedes...")
    listar_hospedes()

    print("Consultando reservas com hospede...")
    reservas_com_hospede()

    print("Consultando reservas com quarto...")
    reservas_com_quarto()


if __name__ == "__main__":
    main()

##-------------------------------------------##

from crud import criar_hospede, listar_hospedes, atualizar_email_hospede, deletar_hospede
from queries import reservas_com_hospede, reservas_com_quarto, reservas_confirmadas


print("CRIANDO HOSPEDES")

criar_hospede("João Silva", "111111", "joao@email.com")
criar_hospede("Maria Souza", "222222", "maria@email.com")
criar_hospede("Carlos Lima", "333333", "carlos@email.com")

print("\nLISTANDO HOSPEDES")
listar_hospedes()


print("\nATUALIZANDO EMAIL")
atualizar_email_hospede(1, "novoemail@email.com")


print("\nCONSULTA RESERVAS COM HOSPEDE")
reservas_com_hospede()


print("\nCONSULTA RESERVAS COM QUARTO")
reservas_com_quarto()


print("\nCONSULTA COM FILTRO")
reservas_confirmadas()


print("\nDELETANDO HOSPEDE")
deletar_hospede(3)

##---------------------------------------##

