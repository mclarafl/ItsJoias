<div align="center">

# 💍 ITS Joias - Sistema de Gestão de Vendas de Joias

![Versão](https://img.shields.io/badge/version-0.1.0-blue)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)
![Projeto](https://img.shields.io/badge/projeto-de%20estudo-purple)
![Frontend](https://img.shields.io/badge/frontend-HTML%20%2F%20CSS%20%2F%20JS-E34F26)
![Backend](https://img.shields.io/badge/backend-Java%20%2F%20Spring%20Boot%204-6DB33F)
![Banco](https://img.shields.io/badge/banco-PostgreSQL%2018-336791)

**Sistema de vendas da marca Leide Farias, "joias com alma baiana"**

[Sobre](#-sobre-o-projeto) •
[Funcionalidades](#-funcionalidades) •
[Tecnologias](#️-tecnologias) •
[Banco de Dados](#️-banco-de-dados) •
[Como Executar](#-como-executar) •
[Roadmap](#️-roadmap) •
[Equipe](#-equipe)

</div>

---

## 📖 Sobre o Projeto

O **ITS Joias** é um sistema web de organização de vendas desenvolvido para a marca **Leide Farias**. A vendedora recebe **maletas** de joias de fornecedores e vende para suas **clientes** à vista ou parcelado. O sistema controla o estoque de cada maleta, as parcelas, os pagamentos e quem está devendo.

> 🎓 **Projeto de estudo.** Este é um projeto pessoal, feito por duas amigas para aprender desenvolvimento full stack na prática. Ele resolve um problema real, mas o objetivo principal é aprender: modelagem de banco de dados, API REST com Spring Boot e interface com React.

### 🎯 Problema que resolvemos

- **Controle no caderno ou na planilha**, sujeito a erro e difícil de consultar
- **Não saber de qual maleta saiu cada peça**, o que atrapalha o acerto com o fornecedor
- **Parcelas e pagamentos espalhados**, sem visão clara de quem está devendo e há quanto tempo
- **Estoque que não bate** com o que foi vendido de verdade

### ✨ Nossa Solução

- ✅ Entrada de maleta com **cadastro automático das peças** e **etiqueta única para cada peça** (`C0001-01`)
- ✅ Venda rápida pela **etiqueta da peça**, ou só pelo modelo, com escolha automática da peça da maleta mais antiga
- ✅ **Rastreio peça por peça**: de qual maleta veio, para quem foi vendida, se foi perdida ou devolvida
- ✅ **Parcelamento** com cálculo automático e controle de cada pagamento
- ✅ Visão de **quem deve, quanto e há quantos dias**
- ✅ **Painel por maleta**: o que chegou, o que foi vendido, o que foi pago e o que está em aberto
- ✅ Banco de dados que **recusa sozinho** o que nunca pode acontecer (pagar a mais, estoque negativo, venda que não fecha a conta)

---

## 🚀 Funcionalidades

> As funcionalidades abaixo estão **planejadas**. Veja o andamento no [Roadmap](#️-roadmap).

### 🧳 Maletas e Estoque

| Funcionalidade | Descrição |
|----------------|-----------|
| **Fornecedores** | Cadastro das lojas e fábricas de onde vêm as maletas |
| **Entrada de Maleta** | Colar a lista da loja e conferir peça por peça antes de gravar |
| **Classificação Automática** | O sistema lê a descrição ("GARGANTILHA VENEZIANA...") e sugere a categoria |
| **Código Próprio** | Cada modelo ganha um código da casa (`C0001`, `A0042`) |
| **Etiqueta por Peça** | Cada unidade física ganha sua etiqueta (`C0001-01`, `C0001-02`...), gerada pelo banco |
| **Modelo Repetido** | Um modelo que volta numa maleta nova é reconhecido pelo código da loja e continua a numeração das etiquetas |
| **Situação da Peça** | Disponível, vendida, perdida ou devolvida ao fornecedor, peça por peça |
| **Histórico de Estoque** | Toda entrada, venda, perda ou devolução de cada peça fica registrada e não pode ser apagada |

### 🛍️ Vendas e Clientes

| Funcionalidade | Descrição |
|----------------|-----------|
| **Clientes** | Busca por nome e cadastro rápido com nome e telefone |
| **Carrinho** | Peças adicionadas pela etiqueta da peça ou pelo código do modelo, com aviso se não houver peça disponível |
| **Prévia da Venda** | Total, parcelas e de qual maleta sai cada peça, antes de confirmar |
| **Acréscimo** | Opção de valor original ou +10% |
| **Parcelamento** | Divisão automática em parcelas, com os centavos que sobram na última |
| **Cancelamento** | Estorno dos pagamentos e devolução das peças para a maleta de origem |

### 💰 Financeiro e Painéis

| Funcionalidade | Descrição |
|----------------|-----------|
| **Recebimentos** | Registro de pagamento por parcela (PIX, dinheiro, cartão, transferência) |
| **Estorno** | Pagamento lançado errado é estornado, nunca apagado |
| **Situação das Parcelas** | Pendente, parcial, paga ou atrasada, com dias de atraso |
| **Saldo por Cliente** | Total comprado, pago, em aberto e atrasado |
| **Resumo Geral** | Total vendido, recebido, a receber e clientes devendo |
| **Painel por Maleta** | Custo, valor vendido, pago e em aberto de cada remessa |
| **Cobranças** *(fase 1.5)* | Histórico de contatos e promessas de pagamento |

---

## 🛠️ Tecnologias

### Frontend

| Tecnologia | Finalidade |
|------------|------------|
| **HTML, CSS e JavaScript** | Protótipo atual da interface |
| **React** *(planejado)* | Interface definitiva |

### Backend

| Tecnologia | Finalidade |
|------------|------------|
| **Java 21** | Linguagem principal |
| **Spring Boot 4** | Framework para a API REST |
| **Spring Data JPA / Hibernate 7** | Acesso ao banco de dados |
| **Bean Validation** | Validação dos dados recebidos |

### Banco de Dados

| Tecnologia | Finalidade |
|------------|------------|
| **PostgreSQL 18** | Banco de dados relacional |
| **pgAdmin 4** | Administração do banco |

---

## 🗄️ Banco de Dados

O banco é criado por um **script único**, [`database/its_joias_banco.sql`](database/its_joias_banco.sql), rodado no pgAdmin. O Spring não cria nem altera tabelas: ele só confere se o código bate com o banco (`ddl-auto=validate`).

### Princípio do desenho

> O banco guarda **fatos**: o que entrou, o que foi vendido, o que foi pago.
> Tudo que é **calculado** (saldo, atraso, estoque por maleta, totais) vem das **views** e nunca vira coluna.

### Visão geral

| Área | Tabelas |
|------|---------|
| **Acesso** | `usuarios` |
| **Clientes** | `clientes`, `cobrancas` |
| **Catálogo** | `categorias`, `categoria_palavras_chave`, `produtos`, `produto_codigos_fornecedor`, `produto_codigos_historico` |
| **Maletas** | `fornecedores`, `maletas`, `maleta_itens`, `pecas` |
| **Vendas** | `vendas`, `itens_venda`, `parcelas`, `pagamentos` |
| **Estoque** | `movimentacoes_estoque` |

**17 tabelas**, **10 views** e **21 triggers**.

### Produto, peça e maleta

| Conceito | Exemplo | O que é |
|----------|---------|---------|
| **Produto** | `C0001` | O modelo: gargantilha veneziana, com nome, categoria e preço |
| **Peça** | `C0001-01` | Cada unidade física desse modelo, com etiqueta própria |
| **Maleta** | Maleta Janeiro | A remessa de onde a peça veio |

A situação de cada peça (disponível, vendida, perdida, devolvida) vem do histórico de estoque dela.

### O que o banco recusa sozinho

As regras de negócio ficam no back-end. O banco é uma **rede de segurança** e recusa o que nunca pode acontecer:

- 🚫 Venda finalizada cuja soma dos itens ou das parcelas não fecha com o total
- 🚫 Pagamento acima do saldo da parcela, ou pagamento apagado ou editado
- 🚫 Cancelar uma venda sem antes estornar os pagamentos e devolver as peças
- 🚫 Vender a mesma peça duas vezes, mesmo com duas pessoas vendendo ao mesmo tempo
- 🚫 Devolver a mesma peça duas vezes, ou na venda errada
- 🚫 Fechar a entrada de uma maleta com etiqueta faltando
- 🚫 Alterar o histórico de estoque, apagar uma peça ou mudar sua etiqueta
- 🚫 Editar o código do produto à mão (ele é gerado pelo banco)

---

## 📁 Estrutura do Projeto

```
ItsJoias/
│
├── backend/
│   ├── .mvn/wrapper/
│   │   └── maven-wrapper.properties
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/br/com/itsjoias/
│   │   │   │   └── ItsJoiasApplication.java
│   │   │   └── resources/
│   │   │       └── application.properties
│   │   └── test/java/br/com/itsjoias/
│   │       └── ItsJoiasApplicationTests.java
│   ├── .gitattributes
│   ├── .gitignore
│   ├── mvnw
│   ├── mvnw.cmd
│   └── pom.xml
│
├── frontend/
│   ├── index.html
│   ├── clientes.html
│   ├── maletas.html
│   ├── produtos.html
│   ├── css/
│   │   └── style.css
│   └── js/
│       └── produtos.js
│
├── database/
│   ├── its_joias_banco.sql
│   └── README.md
│
├── .editorconfig
├── .gitattributes
├── .gitignore
├── CONTRIBUTING.md
└── README.md
```

---

## 💻 Como Executar

### Pré-requisitos

- [PostgreSQL 18](https://www.postgresql.org/download/) com pgAdmin 4
- [Java 21](https://adoptium.net/) *(para o back-end)*
- [Node.js](https://nodejs.org/) *(só quando o front-end em React começar)*

### 1. Banco de dados

1. Clone o repositório
2. No pgAdmin, crie um banco vazio chamado **`its_joias`**
3. Conecte nele e abra `database/its_joias_banco.sql` na **Query Tool**
4. Execute o **arquivo inteiro** (F5), sem selecionar trecho
5. Em *Schemas > public*, clique com o botão direito em **Refresh**. Devem aparecer **17 tabelas** em *Tables* e **10 views** em *Views*

Detalhes, conferência e como registrar mudanças no banco: [`database/README.md`](database/README.md).

### 2. Back-end *(em desenvolvimento)*

O banco precisa estar criado (passo 1). A conexão é configurada por **variáveis de ambiente**;
a senha nunca fica escrita no código.

| Variável | Padrão | Obrigatória |
|----------|--------|-------------|
| `DB_PASSWORD` | — | **Sim** |
| `DB_URL` | `jdbc:postgresql://localhost:5432/its_joias` | Não |
| `DB_USERNAME` | `postgres` | Não |

No **PowerShell** (Windows), dentro da pasta `backend`:

```powershell
$env:DB_PASSWORD = "sua_senha_do_postgres"
.\mvnw.cmd spring-boot:run
```

No **Git Bash**, **Linux** ou **Mac**, dentro da pasta `backend`:

```bash
DB_PASSWORD=sua_senha_do_postgres ./mvnw spring-boot:run
```

A API sobe em `http://localhost:8080`. Os testes rodam com `.\mvnw.cmd test` (PowerShell) ou `./mvnw test` (Git Bash, Linux, Mac), com a mesma variável definida e o banco no ar.

### 3. Front-end *(em breve)*

Enquanto o React não existe, o **protótipo visual** pode ser aberto direto no navegador:
abra `frontend/index.html`. Ele usa só dados fictícios.

---

## 🗺️ Roadmap

As tarefas são acompanhadas no **GitHub Projects**, num quadro com as colunas abaixo:

| Coluna | Significado |
|--------|-------------|
| **Backlog** | Tarefas planejadas |
| **Todo** | Próximas tarefas |
| **In Progress** | Em desenvolvimento |
| **In Review** | Aguardando revisão da outra pessoa |
| **Done** | Concluídas |

### 1. 🗄️ Banco de Dados
**Responsável:** Maria Clara

- [x] Modelagem e criação do banco
- [x] Revisão e testes de vendas, pagamentos e cancelamentos
- [x] Código por peça (etiqueta única por unidade), revisado e testado

### 2. ☕ Back-end - Java e Spring Boot
**Responsabilidade compartilhada**

- [ ] Criar as entidades JPA
- [ ] Conectar o Spring Boot ao PostgreSQL
- [ ] Desenvolver a API REST

### 3. ⚛️ Front-end - React
**Responsável:** Flávia

- [ ] Criar a interface em React
- [ ] Implementar a entrada de maletas
- [ ] Implementar vendas e clientes
- [ ] Criar as telas de recebimentos e painéis

### 4. 🏁 Finalização

- [ ] Login de usuários
- [ ] Testes de integração
- [ ] Cobranças *(fase 1.5)*

---

## 🎨 Cores e Identidade Visual

Marca **Leide Farias**: um sol de traço fino dourado, o nome em letra cursiva, uma onda terracota e a assinatura *"JOIAS COM ALMA BAIANA"*.

| Cor | Código | Uso |
|-----|--------|-----|
| Azul petróleo profundo | `#0C334D` | Cor principal, cabeçalho, rodapé, textos fortes |
| Creme quente | `#FEF6E1` | Fundo principal |
| Dourado claro | `#F0B956` | Sol, botões, destaques |
| Dourado queimado | `#CD8E2A` | Hover, ícones, detalhes |
| Terracota | `#BF6E44` | Ondas, chamadas, detalhes decorativos |
| Creme acinzentado | `#DAD0B8` | Bordas, fundos secundários, cards |
| Cinza petróleo suave | `#535E5D` | Textos secundários |
| Cinza azulado claro | `#929E9F` | Legendas, placeholders |

---

## 📚 O Que Estamos Aprendendo

| Tema | Na prática |
|------|------------|
| **Modelagem de dados** | Chaves compostas, constraints, colunas geradas, views |
| **Integridade no banco** | Triggers de proteção e validação no momento do COMMIT |
| **Concorrência** | Travas para duas vendas não pegarem a mesma peça |
| **API REST** | Controllers, services e repositories com Spring Boot |
| **ORM** | Mapear tabelas e views com JPA/Hibernate |
| **Regras de negócio** | Padrão prévia + confirmação, FIFO, arredondamento de parcelas |
| **Git e GitHub** | Trabalho em dupla com branches e pull requests |

---

## 🤝 Como Trabalhamos

| Branch | Para quê |
|--------|----------|
| `main` | Versão estável. Só recebe código por pull request vindo da `develop` |
| `develop` | Onde o trabalho das duas se junta e é testado |
| `feature/...`, `fix/...`, `docs/...` | Uma por tarefa, criada a partir da `develop` |

1. Crie a branch da tarefa a partir da `develop` (`feature/entrada-maleta`)
2. Faça commits no padrão `tipo: descrição` (`feat: adiciona entrada de maleta`)
3. Abra um **Pull Request para a `develop`**, e a outra revisa antes de juntar

Regras completas (commits, pull requests, mudanças no banco e segurança): [`CONTRIBUTING.md`](CONTRIBUTING.md).

---

## 👥 Equipe

| Nome | Função | GitHub |
|------|--------|--------|
| **Flávia** | Frontend & Backend | [@b0l4da](https://github.com/b0l4da) |
| **Maria Clara** | Banco de Dados & DevOps | [@mclarafl](https://github.com/mclarafl) |


---

## 📄 Licença

Este projeto **não possui licença de uso**. Todos os direitos reservados às autoras.
O código, a modelagem do banco e a documentação não podem ser copiados, distribuídos ou usados
sem autorização.

---

<div align="center">

**Leide Farias - Joias com alma baiana**

</div>
