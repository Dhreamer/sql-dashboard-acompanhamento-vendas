---------------------------------------------------------------------------------------------------
-- CRIANDO A FUNÇÃO DATEDIFF

CREATE FUNCTION datediff (unidade VARCHAR, data_inicial DATE, data_final DATE)
RETURNS INTEGER
LANGUAGE SQL
AS $$
	SELECT
		CASE
			WHEN unidade IN ('d', 'day', 'days') THEN data_final - data_inicial
			WHEN unidade IN ('w', 'week', 'weeks') THEN (data_final - data_inicial)/ 7
			WHEN unidade IN ('m', 'month', 'months') THEN (data_final - data_inicial)/30
			WHEN unidade IN ('y', 'year', 'years') THEN (data_final - data_inicial)/365
			END AS diferenca;
	$$;

DROP FUNCTION datediff (VARCHAR, DATE, DATE);
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------
------ PROJETO SQL 1 - DASHBOARD DE ACOMPANHAMENTO DE VENDAS ------
----------------------------------------------------------------------
-- QUANTIDADE DE PAGAMENTOS E A RECEITA POR MÊS
SELECT
	DATE_TRUNC ('month', visitas.paid_date)::date AS paid_month,
	COUNT (visitas.paid_date) AS paid_count,
	SUM (produtos.price * (1 + visitas.discount)) AS receita
FROM sales.funnel AS visitas
LEFT JOIN sales.products AS produtos
	ON visitas.product_id = produtos.product_id
WHERE paid_date IS NOT NULL
GROUP BY paid_month
ORDER BY paid_month;


-- QUANTIDADE DE VISITAS NO MÊS NO SITE
SELECT
	DATE_TRUNC ('month', visit_page_date)::date AS visit_page_month,
	COUNT (visit_page_date) AS visit_page_count
FROM sales.funnel
GROUP BY visit_page_month
ORDER BY visit_page_month DESC;


-- QUERY COMPLETA - RECEITA, LEADS, CONVERSÃO E TICKET MÉDIO MÊS A MÊS
WITH 
	leads AS
		(SELECT
			DATE_TRUNC ('month', visit_page_date)::date AS visit_page_month,
			COUNT (*) AS visit_page_count
		FROM sales.funnel
		GROUP BY visit_page_month
		ORDER BY visit_page_month),

	payments AS
		(SELECT
			DATE_TRUNC ('month', visitas.paid_date)::date AS paid_month,
			COUNT (visitas.paid_date) AS paid_count,
			SUM (produtos.price * (1 + visitas.discount)) AS receita
		FROM sales.funnel AS visitas
		LEFT JOIN sales.products AS produtos
			ON visitas.product_id = produtos.product_id
		WHERE paid_date IS NOT NULL
		GROUP BY paid_month
		ORDER BY paid_month)

SELECT
	leads.visit_page_month AS "mês",
	leads.visit_page_count AS "leads (#)",
	payments.paid_count AS "vendas (#)",
	(payments.receita/1000) AS "receita (k, R$)",
	(payments.paid_count::float/leads.visit_page_count::float) AS "conversão (%)",
	(payments.receita/payments.paid_count/1000) AS "ticket médio (k, R$)"
FROM leads
LEFT JOIN payments
	ON leads.visit_page_month = paid_month;
	

-- ESTADOS QUE MAIS VENDERAM NO MÊS
SELECT
	'Brazil' AS "país",
	clientes.state AS estado,
	COUNT (visitas.paid_date) AS "vendas (#)"
FROM sales.customers AS clientes
LEFT JOIN sales.funnel AS visitas
	ON clientes.customer_id = visitas.customer_id
WHERE paid_date BETWEEN '2021-08-01' AND '2021-08-31'
GROUP BY "país", estado
ORDER BY "vendas (#)" DESC
LIMIT 5;

-- TOP 5 MARCAS QUE MAIS VENDERAM NO MÊS
SELECT
	produtos.brand AS marca,
	COUNT (visitas.paid_date) AS "vendas (#)"
FROM sales.funnel AS visitas
LEFT JOIN sales.products AS produtos
	ON visitas.product_id = produtos.product_id
WHERE paid_date BETWEEN '2021-08-01' AND '2021-08-31'
GROUP BY marca
ORDER BY "vendas (#)" DESC
LIMIT 5;

-- TOP 5 LOJAS QUE MAIS VENDERAM NO MÊS
SELECT
	lojas.store_name AS loja,
	COUNT (visitas.paid_date) AS "vendas (#)"
FROM sales.funnel AS visitas
LEFT JOIN sales.stores AS lojas
	ON visitas.store_id = lojas.store_id
WHERE paid_date BETWEEN '2021-08-01' AND '2021-08-31'
GROUP BY loja
ORDER BY "vendas (#)" DESC
LIMIT 5;


-- DIAS DA SEMANA COM MAIOR VISITAS NA SEMANA
SELECT
	EXTRACT ('dow' FROM visit_page_date) AS dia_semana,
	CASE
		WHEN EXTRACT ('dow' FROM visit_page_date)=0 THEN 'domingo'
		WHEN EXTRACT ('dow' FROM visit_page_date)=1 THEN 'segunda' 
		WHEN EXTRACT ('dow' FROM visit_page_date)=2 THEN 'terça' 
		WHEN EXTRACT ('dow' FROM visit_page_date)=3 THEN 'quarta' 
		WHEN EXTRACT ('dow' FROM visit_page_date)=4 THEN 'quinta'
		WHEN EXTRACT ('dow' FROM visit_page_date)=5 THEN 'sexta' 
		WHEN EXTRACT ('dow' FROM visit_page_date)=6 THEN 'sábado' 
		ELSE null END AS "dia da semana",
	COUNT (*) AS "visitas (#)"
FROM sales.funnel
WHERE  visit_page_date BETWEEN '2021-08-01' AND '2021-08-31'
GROUP BY dia_semana
ORDER BY dia_semana;