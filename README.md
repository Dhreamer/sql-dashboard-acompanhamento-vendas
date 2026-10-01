# Projeto SQL 1 - Dashboard de Acompanhamento de Vendas

## Sobre o projeto

Esse foi um projeto guiado que desenvolvi durante o curso **SQL para Análise de Dados: Do básico ao avançado**, ministrado pela Midori Toyota na Udemy.

No projeto, simulei a atuação de um analista de dados recém-contratado por um e-commerce de veículos. A empresa funciona como um marketplace, onde diferentes lojas podem cadastrar e vender seus veículos.

Fiz as consultas no PostgreSQL por meio do pgAdmin. Depois, levei os resultados para o Excel e usei os dados para montar o dashboard.

## Objetivo

O objetivo foi criar um dashboard para acompanhar o desempenho comercial do e-commerce, analisando a evolução mensal da receita, do ticket médio, dos leads e da taxa de conversão. Também analisei os principais resultados por estado, marca, loja e dia da semana.

## Perguntas respondidas

- Como a receita evoluiu ao longo dos meses?
- Como o ticket médio evoluiu ao longo dos meses?
- Como a quantidade de leads evoluiu ao longo dos meses?
- Como a taxa de conversão evoluiu ao longo dos meses?
- Quais estados mais venderam no mês analisado?
- Quais foram as cinco marcas mais vendidas no mês?
- Quais foram as cinco lojas que mais venderam no mês?
- Em quais dias da semana aconteceram mais visitas ao site?

## Indicadores e análises apresentados

- Receita mensal
- Ticket médio mensal
- Quantidade mensal de leads
- Taxa de conversão mensal
- Vendas por estado no mês
- Ranking das cinco marcas mais vendidas
- Ranking das cinco lojas que mais venderam
- Visitas ao site por dia da semana

## Banco de dados

A base fictícia usada no projeto representa as operações de um marketplace de veículos.

Principais tabelas consultadas:

- `sales.funnel`: registros relacionados às visitas e vendas
- `sales.products`: informações dos veículos
- `sales.customers`: dados dos clientes
- `sales.stores`: informações das lojas cadastradas

## Recursos SQL aplicados

- Consultas com `SELECT`
- Filtros com `WHERE`
- Relacionamentos entre tabelas com `JOIN`
- Agrupamentos com `GROUP BY`
- Ordenação com `ORDER BY`
- Funções agregadas como `COUNT` e `SUM`
- Subqueries
- Expressões de tabela comuns com `WITH`
- Tratamento de datas com `DATE_TRUNC`
- Conversão de tipos
- Cálculos de receita, ticket médio e taxa de conversão

## Ferramentas utilizadas

- SQL
- PostgreSQL
- pgAdmin
- Microsoft Excel

## Organização do arquivo Excel

O arquivo possui três abas:

| Aba | Conteúdo |
|---|---|
| Dashboard | Apresentação visual dos indicadores e gráficos |
| Resultados das Consultas | Resultados extraídos das consultas executadas no PostgreSQL |
| Consultas SQL | Consultas utilizadas para produzir cada análise |

## Dashboard

![Dashboard de Acompanhamento de Vendas](imagens/Print%20Dashboard%20Projeto%201.jpg)

## Arquivos do projeto

- [Abrir o dashboard em Excel](Dashboard/Projeto%201%20-%20Dashboard%20de%20Vendas.xlsx)
- [Visualizar as consultas SQL](SQL/Querys%20Projeto%201%20-%20Dashboard%20de%20Acompanhamento%20de%20Vendas.sql)

## Estrutura do repositório

```text
sql-dashboard-acompanhamento-vendas/
├── README.md
├── Dashboard/
│   └── Projeto 1 - Dashboard de Vendas.xlsx
├── SQL/
│   └── Querys Projeto 1 - Dashboard de Acompanhamento de Vendas.sql
└── imagens/
    └── Print Dashboard Projeto 1.jpg
```

## Aprendizados

Com esse projeto, consegui aplicar SQL em um cenário de negócio e relacionar diferentes tabelas para transformar dados brutos em indicadores comerciais.

Também pratiquei a extração e a organização dos resultados das consultas, além da apresentação das análises em um dashboard feito no Excel.

## Observação

Este é um projeto guiado, desenvolvido para fins de estudo e portfólio durante o curso **SQL para Análise de Dados: Do básico ao avançado**, da Udemy.
