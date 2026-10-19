-- =====================================================================
-- ITS Joias — telefone e CPF passam a ser guardados COM máscara
--   telefone: (71) 99999-8888  ou  (71) 3333-4444   (até 15 caracteres)
--   cpf:      123.456.789-01                         (14 caracteres)
--
-- COMO RODAR: no pgAdmin, conectado no banco its_joias, abrir este arquivo
-- na Query Tool e executar o ARQUIVO INTEIRO (F5). Rodar UMA vez só.
-- Está tudo numa transação: se qualquer parte falhar, nada é aplicado.
-- Depois disso, o its_joias_banco.sql do repositório já tem a mesma mudança.
-- =====================================================================

BEGIN;

-- 1. A view vw_saldo_clientes usa clientes.telefone. O PostgreSQL não deixa
--    mudar o tamanho de uma coluna usada por view, então ela sai e volta no passo 5.
DROP VIEW vw_saldo_clientes;

-- 2. Sai a regra antiga (só dígitos), senão a conversão do passo 3 seria recusada.
ALTER TABLE clientes DROP CONSTRAINT ck_clientes_telefone;
ALTER TABLE clientes DROP CONSTRAINT ck_clientes_cpf;

-- 3. Colunas maiores e conversão do que já estiver gravado só com dígitos
--    (55 na frente do DDD é retirado; 10 dígitos = fixo, 11 = celular).
ALTER TABLE clientes     ALTER COLUMN telefone TYPE VARCHAR(15);
ALTER TABLE clientes     ALTER COLUMN cpf      TYPE VARCHAR(14);
ALTER TABLE fornecedores ALTER COLUMN telefone TYPE VARCHAR(15);

UPDATE clientes
   SET telefone = regexp_replace(regexp_replace(telefone, '^55([0-9]{10,11})$', '\1'),
                                 '^([0-9]{2})([0-9]{4,5})([0-9]{4})$', '(\1) \2-\3')
 WHERE telefone ~ '^[0-9]{10,13}$';
UPDATE clientes
   SET cpf = regexp_replace(cpf, '^([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})$', '\1.\2.\3-\4')
 WHERE cpf ~ '^[0-9]{11}$';
UPDATE fornecedores
   SET telefone = regexp_replace(regexp_replace(telefone, '^55([0-9]{10,11})$', '\1'),
                                 '^([0-9]{2})([0-9]{4,5})([0-9]{4})$', '(\1) \2-\3')
 WHERE telefone ~ '^[0-9]{10,13}$';

-- 4. Regra nova: só aceita no formato com máscara.
ALTER TABLE clientes ADD CONSTRAINT ck_clientes_telefone
    CHECK (telefone ~ '^\([0-9]{2}\) [0-9]{4,5}-[0-9]{4}$');
ALTER TABLE clientes ADD CONSTRAINT ck_clientes_cpf
    CHECK (cpf IS NULL OR cpf ~ '^[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}$');

-- 5. A view volta, igual a antes.
CREATE VIEW vw_saldo_clientes AS
WITH compras AS (
    SELECT cliente_id, SUM(valor_total) AS total_comprado, COUNT(*) AS qtd_vendas,
           MAX(data_venda) AS ultima_compra
    FROM vendas WHERE status = 'FINALIZADA'
    GROUP BY cliente_id
), fin AS (
    SELECT cliente_id,
           SUM(total_pago)                                AS total_pago,
           SUM(saldo)                                     AS total_em_aberto,
           SUM(saldo) FILTER (WHERE atrasada)             AS total_atrasado,
           COUNT(*)   FILTER (WHERE atrasada)             AS qtd_parcelas_atrasadas,
           MAX(dias_atraso)                               AS maior_dias_atraso,
           MIN(data_vencimento) FILTER (WHERE saldo > 0)  AS vencimento_mais_antigo_em_aberto,
           MAX(ultimo_pagamento)                          AS ultimo_pagamento
    FROM vw_saldo_parcelas
    GROUP BY cliente_id
)
SELECT  c.id                                    AS cliente_id,
        c.nome,
        c.telefone,
        COALESCE(co.qtd_vendas, 0)              AS qtd_vendas,
        COALESCE(co.total_comprado, 0)          AS total_comprado,
        COALESCE(f.total_pago, 0)               AS total_pago,
        COALESCE(f.total_em_aberto, 0)          AS total_em_aberto,
        COALESCE(f.total_atrasado, 0)           AS total_atrasado,
        COALESCE(f.qtd_parcelas_atrasadas, 0)   AS qtd_parcelas_atrasadas,
        COALESCE(f.maior_dias_atraso, 0)        AS maior_dias_atraso,
        f.vencimento_mais_antigo_em_aberto,
        co.ultima_compra,
        f.ultimo_pagamento,
        -- "há quanto tempo sem pagar": só faz sentido para quem deve algo
        CASE WHEN COALESCE(f.total_em_aberto, 0) > 0
             THEN CURRENT_DATE - COALESCE(f.ultimo_pagamento, co.ultima_compra) END AS dias_sem_pagar
FROM clientes c
LEFT JOIN compras co ON co.cliente_id = c.id
LEFT JOIN fin     f  ON f.cliente_id  = c.id;

COMMIT;
