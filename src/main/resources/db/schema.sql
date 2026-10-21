CREATE DATABASE gestao_financeira
    WITH ENCODING = 'UTF8';
    
CREATE TABLE usuarios (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(254) NOT NULL,
    password_hash VARCHAR(100) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_usuarios_email
    ON usuarios (LOWER(email));
    
CREATE TABLE categorias (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    nome VARCHAR(80) NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_categorias_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),

    CONSTRAINT ck_categorias_tipo
        CHECK (tipo IN ('INCOME', 'EXPENSE')),

    CONSTRAINT uk_categorias_usuario_id
        UNIQUE (usuario_id, id),

    CONSTRAINT uk_categorias_nome_tipo
        UNIQUE (usuario_id, nome, tipo)
);

CREATE INDEX idx_categorias_usuario
    ON categorias (usuario_id);
    
CREATE TABLE contas_financeiras (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    saldo_inicial NUMERIC(15,2) NOT NULL DEFAULT 0,
    ativa BOOLEAN NOT NULL DEFAULT TRUE,
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_contas_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),

    CONSTRAINT ck_contas_tipo
        CHECK (tipo IN (
            'CHECKING',
            'SAVINGS',
            'CASH',
            'INVESTMENT',
            'OTHER'
        )),

    CONSTRAINT uk_contas_usuario_id
        UNIQUE (usuario_id, id),

    CONSTRAINT uk_contas_nome
        UNIQUE (usuario_id, nome)
);

CREATE INDEX idx_contas_usuario
    ON contas_financeiras (usuario_id);
    
CREATE TABLE movimentacoes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    conta_id BIGINT NOT NULL,
    categoria_id BIGINT NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    valor NUMERIC(15,2) NOT NULL,
    data_movimentacao DATE NOT NULL,
    observacoes VARCHAR(500),
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_movimentacoes_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),

    CONSTRAINT fk_movimentacoes_conta_usuario
        FOREIGN KEY (usuario_id, conta_id)
        REFERENCES contas_financeiras(usuario_id, id),

    CONSTRAINT fk_movimentacoes_categoria_usuario
        FOREIGN KEY (usuario_id, categoria_id)
        REFERENCES categorias(usuario_id, id),

    CONSTRAINT ck_movimentacoes_tipo
        CHECK (tipo IN ('INCOME', 'EXPENSE')),

    CONSTRAINT ck_movimentacoes_valor
        CHECK (valor > 0),

    CONSTRAINT uk_movimentacoes_usuario_id
        UNIQUE (usuario_id, id)
);

CREATE INDEX idx_movimentacoes_usuario_data
    ON movimentacoes (usuario_id, data_movimentacao DESC);

CREATE INDEX idx_movimentacoes_conta_data
    ON movimentacoes (usuario_id, conta_id, data_movimentacao DESC);

CREATE INDEX idx_movimentacoes_categoria
    ON movimentacoes (usuario_id, categoria_id);
    
 CREATE TABLE contas_a_pagar_receber (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    conta_id BIGINT NOT NULL,
    categoria_id BIGINT NOT NULL,
    movimentacao_id BIGINT UNIQUE,
    tipo VARCHAR(12) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    valor NUMERIC(15,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    status VARCHAR(12) NOT NULL DEFAULT 'OPEN',
    liquidada_em TIMESTAMP,
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_compromissos_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),

    CONSTRAINT fk_compromissos_conta_usuario
        FOREIGN KEY (usuario_id, conta_id)
        REFERENCES contas_financeiras(usuario_id, id),

    CONSTRAINT fk_compromissos_categoria_usuario
        FOREIGN KEY (usuario_id, categoria_id)
        REFERENCES categorias(usuario_id, id),

    CONSTRAINT fk_compromissos_movimentacao_usuario
        FOREIGN KEY (usuario_id, movimentacao_id)
        REFERENCES movimentacoes(usuario_id, id),

    CONSTRAINT ck_compromissos_tipo
        CHECK (tipo IN ('PAYABLE', 'RECEIVABLE')),

    CONSTRAINT ck_compromissos_status
        CHECK (status IN ('OPEN', 'SETTLED', 'CANCELLED')),

    CONSTRAINT ck_compromissos_valor
        CHECK (valor > 0),

    CONSTRAINT ck_compromissos_liquidacao
        CHECK (
            (status = 'SETTLED'
             AND movimentacao_id IS NOT NULL
             AND liquidada_em IS NOT NULL)
            OR
            (status <> 'SETTLED')
        )
);

CREATE INDEX idx_compromissos_usuario_vencimento
    ON contas_a_pagar_receber
       (usuario_id, data_vencimento);

CREATE INDEX idx_compromissos_usuario_status
    ON contas_a_pagar_receber (usuario_id, status);	
  
 CREATE TABLE auditoria (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    entidade VARCHAR(80) NOT NULL,
    entidade_id BIGINT,
    acao VARCHAR(20) NOT NULL,
    detalhes JSONB,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_auditoria_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),

    CONSTRAINT ck_auditoria_acao
        CHECK (acao IN (
            'CREATE',
            'UPDATE',
            'DELETE',
            'SETTLE',
            'CANCEL'
        ))
);

CREATE INDEX idx_auditoria_usuario_data
    ON auditoria (usuario_id, criado_em DESC);

CREATE INDEX idx_auditoria_entidade
    ON auditoria (entidade, entidade_id);
    