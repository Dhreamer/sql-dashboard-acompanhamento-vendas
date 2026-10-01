--------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------
------ PROJETO SQL 2 - DASHBOARD ANÁLISE DE PERFIL DOS CLIENTES ------
----------------------------------------------------------------------

-- STATUS PROFISSIONAL DOS LEADS
SELECT
	CASE 
		WHEN professional_status = 'freelancer' THEN 'freelancer'
		WHEN professional_status = 'retired' THEN 'aposentado(a)'
		WHEN professional_status = 'clt' THEN 'clt'
		WHEN professional_status = 'self_employed' THEN 'autônomo(a)'
		WHEN professional_status = 'other' THEN 'outro'
		WHEN professional_status = 'businessman' THEN 'empresário(a)'
		WHEN professional_status = 'civil_servant' THEN 'funcionário(a) público(a)'
		WHEN professional_status = 'student' THEN 'estudante'
		END AS "status profissional",
	(COUNT (*)::float)/(SELECT COUNT (*) FROM sales.customers) AS "leads (#)"
FROM sales.customers
GROUP BY professional_status
ORDER BY "leads (#)";


-- GENERO DOS LEADS
SELECT
	genero.gender AS "gênero",
	COUNT (genero.gender) AS "leads (#)"
FROM sales.customers AS clientes
LEFT JOIN temp_tables.ibge_genders AS genero
	ON UPPER(clientes.first_name) = UPPER (genero.first_name)
GROUP BY gender;


-- FAIXA ETÁRIA DOS LEADS
SELECT
	CASE
		WHEN datediff('years', birth_date, CURRENT_DATE) < 20 THEN '0-20'
		WHEN datediff('years', birth_date, CURRENT_DATE) < 40 THEN '20-40'
		WHEN datediff('years', birth_date, CURRENT_DATE) < 60 THEN '40-60'
		WHEN datediff('years', birth_date, CURRENT_DATE) < 80 THEN '60-80'
		ELSE '80+' END "faixa etária",
	COUNT(*)::float/(SELECT COUNT(*) FROM sales.customers) AS "leads (%)" 
FROM sales.customers
GROUP BY "faixa etária"
ORDER BY "faixa etária" DESC;


-- FAIXA SALARIAL DOS LEADS
SELECT
	CASE
		WHEN income < 5000 THEN '0-5000'
		WHEN income < 10000 THEN '5000-10000'
		WHEN income < 15000 THEN '10000-15000'
		WHEN income < 20000 THEN '15000-20000'
		ELSE '20000+' END AS "faixa salarial",
		COUNT (*)::float / (SELECT COUNT(*) FROM sales.customers) AS "leads (%)",
	CASE
		WHEN income < 5000 THEN 1
		WHEN income < 10000 THEN 2
		WHEN income < 15000 THEN 3
		WHEN income < 20000 THEN 4
		ELSE 5 END AS "ordem"
FROM sales.customers
GROUP BY "faixa salarial", "ordem"
ORDER BY "ordem" DESC;


-- CLASSIFICAÇÃO DOS VEÍCULOS
WITH
	classificacao_veiculos AS (

	SELECT
		visitas.visit_page_date,
		produtos.model_year,
		extract ('year' FROM visit_page_date) - produtos.model_year::INT AS idade_veiculo,
		CASE
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=2 THEN 'novo'
			ELSE 'seminovo' END AS "classificação do veículo"
	FROM sales.funnel AS visitas
	LEFT JOIN sales.products AS produtos
		ON visitas.product_id = produtos.product_id)
SELECT
	"classificação do veículo",
	COUNT (*) AS "veículos visitados (#)"
FROM classificacao_veiculos
GROUP BY "classificação do veículo";


-- IDADE DOS VEÍCULOS

WITH
	faixa_de_idade_dos_veiculos AS (
	SELECT
		visitas.visit_page_date,
		produtos.model_year,
		extract ('year' FROM visit_page_date) - produtos.model_year::INT AS idade_veiculo,
		CASE
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=2 THEN 'até 2 anos'
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=4 THEN 'de 2 a 4 anos'
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=6 THEN 'de 4 a 6 anos'
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=8 THEN 'de 6 a 8 anos'
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=10 THEN 'de 8 a 10 anos'
			ELSE 'acima de 10 anos' END AS "idade do veículo",
		CASE
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=2 THEN 1
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=4 THEN 2
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=6 THEN 3
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=8 THEN 4
			WHEN (extract ('year' FROM visit_page_date) - produtos.model_year::INT)<=10 THEN 5
			ELSE 6 END AS "ordem"
	FROM sales.funnel AS visitas
	LEFT JOIN sales.products AS produtos
		ON visitas.product_id = produtos.product_id)
SELECT
	"idade do veículo",
	COUNT (*)::float/ (SELECT COUNT (*) FROM sales.funnel) AS "veículos visitados (%)",
	ordem
FROM faixa_de_idade_dos_veiculos
GROUP BY "idade do veículo", ordem
ORDER BY ordem;


-- VEÍCULOS MAIS VISITADOS POR MARCA
SELECT
	produtos.brand,
	produtos.model,
	COUNT(*) AS "visitas (#)"
FROM sales.funnel AS visitas
LEFT JOIN sales.products AS produtos
	ON visitas.product_id = produtos.product_id
GROUP BY produtos.brand, produtos.model
ORDER BY produtos.brand, produtos.model, "visitas (#)";