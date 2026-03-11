Projeto Hotel - CRUD com ORM SQLAlchemy

## Descrição do Projeto
Este projeto implementa uma aplicação de gerenciamento de **hóspedes, quartos e reservas** de um hotel, conectada a um banco **PostgreSQL**, utilizando **SQLAlchemy ORM** para mapear as tabelas em classes Python e realizar operações de CRUD e consultas sem SQL manual.

O projeto inclui:  

- Mapeamento ORM completo das tabelas `hospedes`, `quartos` e `reservas`  
- Relacionamentos entre tabelas (`OneToMany`, `ManyToOne`)  
- Funções de **CRUD** (CREATE, READ, UPDATE, DELETE)  
- Consultas avançadas com **JOINs**, filtros, ordenação e agregações  
- Exemplo de execução com prints no terminal  

---

## Pré-requisitos
- Python 3.10+  
- PostgreSQL 12+  
- Biblioteca `pip` instalada  

---

## Configuração do Banco de Dados
1. Crie o banco PostgreSQL com o script fornecido (`script.sql`), que inclui:  
   - Criação das tabelas `hospedes`, `quartos` e `reservas`  
   - Regras de integridade, views, triggers e índices  
2. Configure o arquivo `.env` na raiz do projeto com os dados do seu banco:

```env
DB_USER=postgres
DB_PASSWORD=123
DB_HOST=localhost
DB_PORT=5432
DB_NAME=hotel

## Evidência de funcionamento

### CREATE
![CREATE](prints/print_create.png)

### READ
![READ](prints/print_read.png)

### UPDATE
![UPDATE](prints/print_update.png)

### DELETE
![DELETE](prints/print_delete.png)

### CONSULTAS
![CONSULTAS](prints/print_consultas.png)
