-- Dicionarios de tabelas
SELECT
    *
FROM
    GDIC;

-- Usando dicionario para buscar colunas com # que são as tables
SELECT
    *
FROM
    GDIC
WHERE
    COLUNA = '#';

-- Usando outras colunar para buscar nesse caso tabela financeira
SELECT
    *
FROM
    GDIC
WHERE
    COLUNA = '#'
    AND TABELA LIKE 'F%'
    AND DESCRICAO LIKE '%LANÇAMENTO%';

-- Usando dicionário para buscar campo de fornecedores
SELECT
    *
FROM
    GDIC
WHERE
    COLUNA = '#'
    AND DESCRICAO LIKE '%FORNECEDOR%';

-- Table de Cliente/Fornecedor
SELECT
    *
FROM
    FCFO -- Mostra o que cada letra de início das tabelas representam pelo gsistema
SELECT
    *
FROM
    GSISTEMA
ORDER BY
    CODSISTCOMERCIAL;

-- GLINKSREL mostra o relacionamento que as tables tem
SELECT
    *
FROM
    GLINKSREL;

-- Mostra todos os relacionamentos referentes a table FLAN - lançmentos.
SELECT
    *
FROM
    GLINKSREL
WHERE
    MASTERTABLE = 'FLAN';

-- Mostra os lançamentos de todos Clientes/Fornecedores por documento e valor.
SELECT
    FCFO.NOME,
    FLAN.NUMERODOCUMENTO,
    FLAN.VALORORIGINAL
FROM
    FCFO
    INNER JOIN FLAN ON FCFO.CODCFO = FLAN.CODCFO
GROUP BY
    FCFO.NOME,
    FLAN.NUMERODOCUMENTO,
    FLAN.VALORORIGINAL
ORDER BY
    FCFO.NOME;

-- Mostra os totais por Cliente/Fornecedor sem filtrar ativos ou não.
SELECT
    CLIFORN.NOME,
    SUM(LANCA.VALORORIGINAL) AS VALORTOTAL
FROM
    FCFO AS CLIFORN
    INNER JOIN FLAN AS LANCA ON CLIFORN.CODCFO = LANCA.CODCFO
GROUP BY
    CLIFORN.NOME
ORDER BY
    CLIFORN.NOME;

-- Mostra os totais por Cliente/Fornecedor sem filtrar ativos ou não, colocando uma linha no final mostrando o total
SELECT
    NOME,
    VALORTOTAL
FROM
    (
        SELECT
            FCFO.NOME,
            SUM(FLAN.VALORORIGINAL) AS VALORTOTAL
        FROM
            FCFO
            INNER JOIN FLAN ON FCFO.CODCFO = FLAN.CODCFO
        GROUP BY
            FCFO.NOME WITH ROLLUP
    ) AS RESULTADO
ORDER BY
    CASE
        WHEN NOME IS NULL THEN 1
        ELSE 0
    END,
    NOME;

-- Mostra os totais por Cliente/Fornecedor filtrando os ativos, colocando uma linha no final mostrando o total
SELECT
    NOME,
    VALORTOTAL
FROM
    (
        SELECT
            FCFO.NOME,
            SUM(FLAN.VALORORIGINAL) AS VALORTOTAL
        FROM
            FCFO
            INNER JOIN FLAN ON FCFO.CODCFO = FLAN.CODCFO
        WHERE
            FCFO.ATIVO = 1
        GROUP BY
            FCFO.NOME WITH ROLLUP
    ) AS RESULTADO
ORDER BY
    CASE
        WHEN NOME IS NULL THEN 1
        ELSE 0
    END,
    NOME;

-- Mostra clientes que tem a data de criação que não estão como null
SELECT
    FCFO.NOME,
    FCFO.DATACRIACAO
FROM
    FCFO
    INNER JOIN FLAN ON FCFO.CODCFO = FLAN.CODCFO
WHERE
    FCFO.DATACRIACAO IS NOT NULL
GROUP BY
    FCFO.NOME,
    FCFO.DATACRIACAO
ORDER BY
    FCFO.NOME;
