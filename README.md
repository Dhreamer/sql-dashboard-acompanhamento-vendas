# Projeto SQL 1 - Dashboard de Acompanhamento de Vendas

## Sobre o projeto

Esse foi um projeto guiado que desenvolvi durante o curso **SQL para Análise de Dados: Do básico ao avançado**, ministrado pela Midori Toyota na Udemy.

No projeto, simulei a atuação de um analista de dados recém-contratado por um e-commerce de veículos. A empresa funciona como um marketplace, onde diferentes lojas podem cadastrar e vender seus veículos.

Realizei as consultas no PostgreSQL por meio do pgAdmin. Depois, organizei os resultados no Excel e usei esses dados para montar um dashboard com os principais indicadores e análises comerciais.

## Objetivo

O objetivo foi criar um dashboard para acompanhar o desempenho comercial do e-commerce. Para isso, analisei a evolução mensal da receita, do ticket médio, da quantidade de leads e do indicador de conversão calculado no exercício.

Também observei a distribuição das vendas por estado, marca e loja, além do volume de visitas ao site por dia da semana.

## Perguntas de negócio

Para orientar as análises, trabalhei com seis perguntas:

1. Como evoluíram a receita e o ticket médio dos veículos vendidos no e-commerce ao longo dos meses?
2. Como evoluíram a quantidade de leads e a conversão desses leads em contratos pagos ao longo dos meses?
3. Quais estados registraram o maior número de vendas no mês analisado?
4. Quais marcas registraram o maior número de vendas no mês analisado?
5. Quais foram as cinco lojas que mais venderam no mês analisado?
6. Em quais dias da semana ocorreu o maior volume de visitas ao site no mês analisado?

## Indicadores e análises apresentados

O dashboard reúne seis análises:

- Evolução mensal da receita e do ticket médio;
- Evolução mensal da quantidade de leads e do indicador de conversão;
- Vendas por estado;
- Vendas por marca;
- Vendas por loja;
- Visitas ao site por dia da semana.

## Principais resultados

A análise dos resultados permitiu identificar alguns padrões no período estudado:

- **Receita:** entre outubro de 2020 e agosto de 2021, passou de aproximadamente R$ 1,68 milhão para R$ 68,27 milhões.
- **Ticket médio:** apresentou oscilações durante o período, mas ficou relativamente estável nos últimos quatro meses analisados.
- **Leads:** a quantidade de registros passou de 931 em outubro de 2020 para 6.353 em agosto de 2021.
- **Indicador de conversão:** depois de apresentar valores menores nos primeiros meses, chegou a 19,74% em agosto de 2021. Esse percentual representa a relação entre vendas pagas e leads registrados no mesmo mês, não uma conversão individual comprovada.
- **Estados:** São Paulo liderou o ranking de agosto de 2021, com 734 vendas.
- **Marcas:** FIAT registrou o maior número de vendas, com 248, seguida por Chevrolet, com 237.
- **Lojas:** entre as cinco linhas retornadas pela consulta, o maior volume foi de 18 vendas. Houve empate entre lojas com 10 vendas.
- **Dias da semana:** segunda-feira apresentou o maior volume de visitas, com 1.301 registros.

As análises completas, com gráficos, interpretações e observações sobre os resultados, estão disponíveis no documento complementar:

[**Consultar a análise completa dos resultados (PDF)**](An%C3%A1lise%20dos%20resultados/Projeto1_An%C3%A1lise_dos_Resultados.pdf)

## Banco de dados

A base fictícia utilizada no projeto representa as operações de um marketplace de veículos.

Principais tabelas consultadas:

- `sales.funnel`: registros relacionados às visitas e vendas;
- `sales.products`: informações dos veículos;
- `sales.customers`: dados dos clientes;
- `sales.stores`: informações das lojas cadastradas.

## Recursos SQL aplicados

Durante o desenvolvimento, utilizei recursos do SQL para consultar, relacionar, agrupar e analisar os dados, incluindo:

- Consultas com `SELECT`;
- Filtros com `WHERE`;
- Relacionamentos entre tabelas com `JOIN` e `LEFT JOIN`;
- Agrupamentos com `GROUP BY`;
- Ordenação com `ORDER BY`;
- Funções agregadas como `COUNT` e `SUM`;
- Expressões de tabela comuns com `WITH` (CTEs);
- Tratamento de datas com `DATE_TRUNC` e `EXTRACT`;
- Condições com `CASE`;
- Conversão de tipos;
- Cálculos de receita, ticket médio e indicadores percentuais.

Além das consultas principais, também realizei verificações adicionais no PostgreSQL para conferir alguns aspectos da base e dos cálculos utilizados. Os resultados dessas verificações estão resumidos aqui e detalhados no documento complementar.

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
- [Consultar a análise completa dos resultados (PDF)](An%C3%A1lise%20dos%20resultados/Projeto1_An%C3%A1lise_dos_Resultados.pdf)

## Verificações adicionais

Além de desenvolver as consultas para responder às perguntas de negócio, também conferi alguns pontos da base e dos cálculos para entender melhor os resultados.

As verificações incluíram:

- Distribuição dos descontos nas vendas pagas e comportamento da fórmula utilizada para calcular a receita;
- Tipos de dados das colunas de data;
- Correspondência entre as vendas e os produtos cadastrados;
- Existência de produtos sem preço;
- Duplicidade de identificadores de produtos;
- Distribuição dos registros de visitas em setembro de 2020.

Nas vendas pagas, encontrei 3.724 registros com desconto negativo e 64 sem desconto. Não foram encontrados descontos positivos. As colunas `paid_date` e `visit_page_date` utilizam o tipo `DATE`.

Também não encontrei vendas sem correspondência na tabela de produtos, produtos sem preço ou `product_id` duplicados. Em setembro de 2020, foram registrados 26 leads distribuídos em 15 dias, entre os dias 2 e 29.

Essas verificações ajudaram a conferir os cálculos e a considerar as limitações dos dados na interpretação dos resultados.

## Estrutura do repositório

```text
sql-dashboard-acompanhamento-vendas/
├── README.md
├── Dashboard/
│   └── Projeto 1 - Dashboard de Vendas.xlsx
├── SQL/
│   └── Querys Projeto 1 - Dashboard de Acompanhamento de Vendas.sql
├── Análise dos resultados/
│   └── Projeto1_Análise_dos_Resultados.pdf
└── imagens/
    └── Print Dashboard Projeto 1.jpg
```

## Aprendizados

Com esse projeto, consegui aplicar SQL em um cenário de negócio, relacionando diferentes tabelas para transformar dados em indicadores comerciais.

Também pratiquei a extração e a organização dos resultados das consultas, a construção de gráficos no Excel e a criação de um dashboard para apresentar as informações.

Além disso, pude aprofundar a análise dos resultados, conferir a consistência dos dados e identificar limitações que precisam ser consideradas na interpretação dos indicadores.

## Observação

Este é um projeto guiado, desenvolvido para fins de estudo e portfólio durante o curso **SQL para Análise de Dados: Do básico ao avançado**, da Udemy.
