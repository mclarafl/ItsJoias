# Como trabalhamos no ITS Joias

Regras combinadas entre Maria Clara ([@mclarafl](https://github.com/mclarafl)) e Flávia ([@b0l4da](https://github.com/b0l4da)).

---

## 🌿 Branches

| Branch | Para quê | Quem escreve nela |
|--------|----------|-------------------|
| `main` | Versão estável, que funciona | Ninguém direto. Só por pull request vindo da `develop` |
| `develop` | Onde o trabalho das duas se junta e é testado | Ninguém direto. Só por pull request das branches de tarefa |
| `feature/...` | Funcionalidade nova | Quem está fazendo a tarefa |
| `fix/...` | Correção de bug | Quem está corrigindo |
| `docs/...` | Só documentação | Quem está escrevendo |
| `chore/...` | Organização, configuração, dependências | Quem está mexendo |

**Nome da branch:** tipo + barra + descrição curta, em minúsculas, com hífen.
Ex.: `feature/entrada-maleta`, `fix/arredondamento-parcelas`, `docs/guia-banco`.

Uma branch por tarefa do quadro do GitHub Projects. Terminou e juntou? A branch é apagada.

---

## 🔁 Passo a passo de uma tarefa

```bash
# 1. Atualize a develop
git checkout develop
git pull

# 2. Crie a branch da tarefa
git checkout -b feature/entrada-maleta

# 3. Trabalhe e faça commits pequenos
git add .
git commit -m "feat: adiciona prévia da entrada de maleta"

# 4. Envie a branch
git push -u origin feature/entrada-maleta
```

5. No GitHub, abra um **Pull Request para a `develop`**.
6. Mova a tarefa no quadro para **In Review**.
7. A outra revisa, comenta e aprova. Só então o PR é juntado (*merge*).
8. Mova a tarefa para **Done** e apague a branch.

Para levar a `develop` para a `main` (uma versão estável): PR de `develop` → `main`, revisado pelas duas.

---

## ✍️ Padrão de commits

`tipo: descrição no imperativo, em minúsculas`

| Tipo | Quando usar | Exemplo |
|------|-------------|---------|
| `feat` | Funcionalidade nova | `feat: adiciona busca de peça pela etiqueta` |
| `fix` | Correção de bug | `fix: corrige arredondamento da última parcela` |
| `docs` | Documentação | `docs: explica como criar o banco` |
| `style` | Formatação, sem mudar comportamento | `style: aplica cores da marca na tela de vendas` |
| `refactor` | Reorganiza código, sem mudar comportamento | `refactor: separa cálculo de parcelas em um serviço` |
| `test` | Testes | `test: cobre cancelamento com estorno` |
| `chore` | Configuração, dependências, organização | `chore: organiza estrutura de pastas` |
| `db` | Mudança no banco (script ou alteração) | `db: adiciona view de acerto com fornecedor` |

---

## ✅ Antes de abrir o pull request

- [ ] O código roda na sua máquina
- [ ] O PR faz **uma coisa só** (a tarefa do quadro)
- [ ] Não tem senha, chave, token nem dado real de cliente
- [ ] Se mexeu no banco, seguiu as regras abaixo
- [ ] A descrição do PR diz o que mudou e como testar

---

## 🗄️ Mudanças no banco de dados

O banco é criado e alterado **à mão, pelo pgAdmin**. O Spring nunca altera tabelas.

1. Escreva a mudança num arquivo novo em `database/alteracoes/`, com o nome
   `AAAA-MM-DD_descricao.sql` (ex.: `2026-11-03_view_acerto_fornecedor.sql`).
2. Atualize também o `database/its_joias_banco.sql`, para ele continuar criando o banco completo do zero.
3. No PR, avise a outra: ela precisa rodar o arquivo de alteração no banco dela.

Detalhes em [`database/README.md`](database/README.md).

---

## 🔒 Segurança

O repositório guarda **código e scripts**, nunca dados nem segredos.

- **Nunca suba** senha do banco, `.env`, `application-local.properties`, chaves ou tokens.
  Se precisar de um modelo de configuração, crie um `.env.example` só com os nomes das variáveis, sem valores de verdade.
- **Nunca suba** dados reais de clientes (nome, telefone, CPF, endereço) nem backups do banco.
  Dados de teste são sempre fictícios.
- Subiu um segredo por engano? **Troque a senha/chave na hora.** Apagar o arquivo depois não basta:
  ele continua no histórico do Git.
