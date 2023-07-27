-- Criação da tabela Departamentos
CREATE TABLE departamentos (
	codigo_departamento int PRIMARY KEY ,
	nome_departamento varchar(100) NOT NULL,
	CONSTRAINT validacao_codigo CHECK (codigo_departamento > 0)
);


-- Inserindo linhas
INSERT INTO departamentos
VALUES (1, 'Departamento de Matemática'),
       (2, 'Departamento de Física'),
       (3, 'Departamento de Química'),
       (4, 'Departamento de Biologia'),
       (5, 'Departamento de Sociologia'),
       (6, 'Departamento de Engenharia Elétrica'),
       (7, 'Departamento de Psicologia'),
       (8, 'Departamento de Ciências da Computação'),
       (9, 'Departamento de Administração'),
       (10, 'Departamento de Letras');

-- Visualizando a tabela
SELECT * FROM departamentos;

----------------------------------------------------------------------------------------------------
-- Criação da tabela Orientadores
CREATE TABLE orientadores (
	codigo_orientador int PRIMARY KEY ,
	nome_orientador varchar(100) NOT NULL,
	codigo_departamento int REFERENCES departamentos(codigo_departamento),
	CONSTRAINT validacao_codigo CHECK (codigo_orientador > 0)
);

-- Inserindo linhas 
INSERT INTO orientadores (codigo_orientador, nome_orientador, codigo_departamento)
VALUES 
    (1, 'João Silva', 1),
    (2, 'Maria Santos', 2),
    (3, 'Pedro Rocha', 3),
    (4, 'Ana Oliveira', 4),
    (5, 'Paulo Souza', 5),
    (6, 'Carla Mendes', 6),
    (7, 'Fernando Santos', 7),
    (8, 'Julia Lima', 8),
    (9, 'Antonio Pereira', 9),
    (10, 'Mariana Almeida', 10),
    (11, 'Roberto Santos', 1),
    (12, 'Luiza Fernandes', 2),
    (13, 'Ricardo Silva', 3),
    (14, 'Sandra Costa', 4),
    (15, 'Lucas Oliveira', 5),
    (16, 'Isabela Rodrigues', 6),
    (17, 'Marcos Souza', 7),
    (18, 'Patricia Lima', 8),
    (19, 'Gustavo Pereira', 9),
	(20, 'Gabriela Almeida', 10);

-- Visualiza 
SELECT * FROM orientadores;

----------------------------------------------------------------------------------------------------
-- Criação da tabela Disciplinas
CREATE TABLE disciplinas (
	codigo_disciplina int PRIMARY KEY ,
	nome_disciplina varchar(100) NOT NULL,
	ementa varchar(200) NOT NULL,
	numero_creditos int NOT NULL, 
	codigo_departamento int REFERENCES departamentos(codigo_departamento),
	codigo_orientador int REFERENCES orientadores(codigo_orientador),
	CONSTRAINT validacao_codigo CHECK (codigo_orientador > 0)
);

-- Inserindo linhas
INSERT INTO disciplinas (codigo_disciplina, nome_disciplina, ementa, numero_creditos,codigo_departamento,codigo_orientador)
VALUES
(1, 'Introdução à Programação', 'Conceitos básicos de programação', 9,8,8),
(2, 'Cálculo I Eng. Elet.', 'Funções, limites e derivadas', 27,6,6),
(3, 'Álgebra Linear', 'Sistemas de equações lineares', 22,1,1),
(4, 'Física I', 'Mecânica Clássica', 18,2,2),
(5, 'Química Geral', 'Propriedades da matéria e reações químicas', 4,3,3),
(6, 'Programação Orientada a Objetos', 'Conceitos básicos de POO', 42,8,8),
(7, 'Banco de Dados I', 'Conceitos básicos de banco de dados', 32,8,8),
(8, 'Redes de Computadores', 'Topologias, protocolos e segurança de redes', 16,8,8),
(9, 'Desenvolvimento WEB', 'Processos, modelos e práticas de desenvolvimento em WEB', 14,8,8),
(10, 'Sistemas Operacionais', 'Gerenciamento de processos e recursos em sistemas operacionais', 13,8,8),
(11, 'Imunologia', 'Sistema imunológico e imunidade', 5,4,4),
(12, 'Microbiologia', 'Estudo dos microrganismos', 7,4,4),
(13, 'Sociologia do Trabalho', 'Estudo das relações de trabalho na sociedade', 56,5,5),
(14, 'Sociologia da Cultura', 'Análise da cultura na sociedade', 41,5,5),
(15, 'Psicopatologia', 'Estudo dos transtornos psicológicos', 22,7,7),
(16, 'Psicologia Clínica', 'Estudo da psicologia clínica', 32,7,7),
(17, 'Economia', 'Princípios básicos da economia', 61,9,9),
(18, 'Finanças', 'Estudo das finanças nas organizações', 25,9,9),
(19, 'Língua Portuguesa', 'Estudo da língua portuguesa', 4,10,10),
(20, 'Literatura Brasileira', 'Estudo da literatura brasileira',4,10,10),
(21, 'Literatura Clássica', 'Estudo da literatura clássica', 50,10, 15);


-- Visualizar 
SELECT * FROM disciplinas;

----------------------------------------------------------------------------------------------------

-- Criação da tabela Disciplina_prerequisito: AUTORELACIONAMENTO COM DISCIPLINA
CREATE TABLE disciplina_pre_requisito (
	codigo_disciplina int REFERENCES disciplinas(codigo_disciplina),
	codigo_pre_requisito int REFERENCES disciplinas(codigo_disciplina), 
	PRIMARY KEY (codigo_disciplina, codigo_pre_requisito)
);

-- Inserindo dados
INSERT INTO disciplina_pre_requisito VALUES
(9, 1),
(20, 19),
(18, 17),
(6, 1);

-- Visualizando com nome da disiciplina PRE-REQUISTO
SELECT 
disciplina_pre_requisito.codigo_disciplina,
disciplina_pre_requisito.codigo_pre_requisito,
disciplinas.nome_disciplina
FROM disciplinas INNER JOIN disciplina_pre_requisito 
ON disciplinas.codigo_disciplina = disciplina_pre_requisito.codigo_pre_requisito ; 

-- Visualizando com nome da disiciplina QUE TEM PRE-REQUISTO

SELECT 
disciplina_pre_requisito.codigo_disciplina,
disciplinas.nome_disciplina,
disciplina_pre_requisito.codigo_pre_requisito
FROM disciplinas INNER JOIN disciplina_pre_requisito USING (codigo_disciplina); 

-- Visualizando 
SELECT * FROM disciplina_pre_requisito;


----------------------------------------------------------------------------------------------------
-- Criação disciplina_aluno
CREATE TABLE disciplina_aluno(
	codigo_aluno int REFERENCES alunos,
	codigo_disciplina int REFERENCES disciplinas,
	media_final decimal NOT NULL,
	frequencia decimal NOT NULL, 
	PRIMARY KEY (codigo_aluno, codigo_disciplina)
);

-- Inserir linhas
INSERT INTO disciplina_aluno (codigo_aluno, codigo_disciplina, media_final, frequencia) VALUES 
    (1, 1, 8.5, 0.92),
    (1, 2, 9.0, 0.95),
    (1, 3, 7.0, 0.80),
    (2, 4, 7.5, 0.90),
    (2, 5, 8.0, 0.85),
    (2, 6, 6.5, 0.70),
    (3, 7, 9.0, 0.95),
    (3, 8, 9.5, 0.98),
    (3, 9, 8.0, 0.85),
    (4, 10, 6.0, 0.75),
    (4, 11, 7.0, 0.80),
    (4, 12, 5.5, 0.65),
    (5, 13, 8.0, 0.85),
    (5, 14, 7.5, 0.90),
    (5, 15, 7.0, 0.80),
    (6, 16, 9.5, 0.98),
    (6, 17, 9.0, 0.95),
    (6, 18, 8.5, 0.92),
    (7, 19, 7.0, 0.80),
    (7, 20, 6.5, 0.70);
	
-- Visualizar
SELECT * FROM disciplina_aluno;

----------------------------------------------------------------------------------------------------

-- Criação Aluno
CREATE TABLE alunos(
	codigo_aluno int PRIMARY KEY,
	nome_aluno varchar(100) NOT NULL,
	logradouro varchar(20) NOT NULL,
	numero int NOT NULL,
	bairro varchar(100) NOT NULL,
	cidade varchar(50) NOT NULL,
	CONSTRAINT validacao_codigo CHECK (codigo_aluno > 0)
);

ALTER TABLE alunos ADD nivel_escolar varchar(15);

UPDATE alunos SET nivel_escolar='graduação' WHERE codigo_aluno>30;
UPDATE alunos SET nivel_escolar='pós-graduação' WHERE codigo_aluno<30;
UPDATE alunos SET nivel_escolar='pós-graduação' WHERE codigo_aluno=30;

ALTER TABLE alunos ALTER COLUMN nivel_escolar SET NOT NULL;


-- Inserir linhas aluno
INSERT INTO alunos (codigo_aluno, nome_aluno, logradouro, numero, bairro, cidade) 
VALUES
(1, 'João Silva', 'Rua A', 100, 'Centro', 'São Paulo'),
(2, 'Maria Santos', 'Rua B', 200, 'Vila Mariana', 'São Paulo'),
(3, 'Pedro Souza', 'Rua C', 300, 'Moema', 'São Paulo'),
(4, 'Ana Oliveira', 'Rua D', 400, 'Pinheiros', 'São Paulo'),
(5, 'Lucas Costa', 'Rua E', 500, 'Lapa', 'São Paulo'),
(6, 'Camila Fernandes', 'Rua F', 600, 'Jardins', 'São Paulo'),
(7, 'Rodrigo Santos', 'Rua G', 700, 'Tatuapé', 'São Paulo'),
(8, 'Leticia Rodrigues', 'Rua H', 800, 'Itaim Bibi', 'São Paulo'),
(9, 'Gustavo Ferreira', 'Rua I', 900, 'Mooca', 'São Paulo'),
(10, 'Isabela Silva', 'Rua J', 1000, 'Vila Leopoldina', 'São Paulo'),
(11, 'Vinicius Oliveira', 'Rua K', 1100, 'Santo Amaro', 'São Paulo'),
(12, 'Mariana Costa', 'Rua L', 1200, 'Morumbi', 'São Paulo'),
(13, 'Rafaela Santos', 'Rua M', 1300, 'Brooklin', 'São Paulo'),
(14, 'Bruno Souza', 'Rua N', 1400, 'Perdizes', 'São Paulo'),
(15, 'Carla Oliveira', 'Rua O', 1500, 'Campo Belo', 'São Paulo'),
(16, 'Thiago Fernandes', 'Rua P', 1600, 'Vila Olímpia', 'São Paulo'),
(17, 'Renata Souza', 'Rua Q', 1700, 'Alphaville', 'Barueri'),
(18, 'Leandro Costa', 'Rua R', 1800, 'Granja Viana', 'Cotia'),
(19, 'Fabiana Oliveira', 'Rua S', 1900, 'Jardim Europa', 'São Paulo'),
(20, 'Diego Santos', 'Rua T', 2000, 'São Bento', 'São Paulo'),
(21, 'Juliana Ferreira', 'Rua U', 2100, 'Vila Madalena', 'São Paulo'),
(22, 'Luciana Souza', 'Rua V', 2200, 'Pinheiros', 'São Paulo'),
(23, 'Carlos Costa', 'Rua W', 2300, 'Jardim Paulista', 'São Paulo'),
(24, 'Renan Oliveira', 'Rua X', 2400, 'Santana', 'São Paulo'),
(25, 'Vanessa Santos', 'Rua Y', 2500, 'Liberdade', 'São Paulo'),
(26, 'Thales Ferreira', 'Rua Z', 2600, 'Vila Mar', 'São Paulo'),
(27, 'Luiza Silva', 'Avenida A', 2700, 'Jardim América', 'São Paulo'),
(28, 'Victor Oliveira', 'Avenida B', 2800, 'Campo Limpo', 'São Paulo'),
(29, 'Beatriz Costa', 'Avenida C', 2900, 'Tucuruvi', 'São Paulo'),
(30, 'Fernando Santos', 'Avenida D', 3000, 'Lapa', 'São Paulo'),
(31, 'Thais Ferreira', 'Avenida E', 3100, 'Jardim Paulistano', 'São Paulo'),
(32, 'Guilherme Souza', 'Avenida F', 3200, 'Paraíso', 'São Paulo'),
(33, 'Amanda Oliveira', 'Avenida G', 3300, 'Santa Cecília', 'São Paulo'),
(34, 'Leonardo Costa', 'Avenida H', 3400, 'Alto da Lapa', 'São Paulo'),
(35, 'Caroline Santos', 'Avenida I', 3500, 'Moema', 'São Paulo'),
(36, 'Thiago Silva', 'Avenida J', 3600, 'Vila Prudente', 'São Paulo'),
(37, 'Priscila Ferreira', 'Avenida K', 3700, 'Jardim São Paulo', 'São Paulo'),
(38, 'Marcelo Souza', 'Avenida L', 3800, 'Vila Guilherme', 'São Paulo'),
(39, 'Mariana Oliveira', 'Avenida M', 3900, 'Vila Carrão', 'São Paulo'),
(40, 'Lucas Ferreira', 'Avenida N', 4000, 'São João Clímaco', 'São Paulo'),
(41, 'Isabela Costa', 'Avenida O', 4100, 'Jardim Europa', 'São Paulo'),
(42, 'João Souza', 'Avenida P', 4200, 'Jabaquara', 'São Paulo'),
(43, 'Aline Ferreira', 'Avenida Q', 4300, 'Vila Romana', 'São Paulo'),
(44, 'Pedro Oliveira', 'Avenida R', 4400, 'Vila Mariana', 'São Paulo'),
(45, 'Camila Santos', 'Avenida S', 4500, 'Jardim das Flores', 'São Paulo'),
(46, 'Rafael Costa', 'Avenida T', 4600, 'Mooca', 'São Paulo'),
(47, 'Larissa Silva', 'Avenida U', 4700, 'Vila Olímpia', 'São Paulo'),
(48, 'Gustavo Ferreira', 'Avenida V', 4800, 'Alto de Pinheiros', 'São Paulo'),
(49, 'Renata Souza', 'Avenida W', 4900, 'Parque São Lucas', 'São Paulo'),
(50, 'Felipe Oliveira', 'Avenida X', 5000, 'Cidade Dutra', 'São Paulo'),
(51, 'Laura Santos', 'Avenida Y', 5100, 'Vila Clementino', 'São Paulo'),
(52, 'Vinicius Costa', 'Avenida Z', 5200, 'Jardim Peri', 'São Paulo'),
(53, 'Bianca Ferreira', 'Rua A', 5300, 'Itaim Bibi', 'São Paulo'),
(54, 'Gabriel Oliveira', 'Rua B', 5400, 'Tatuapé', 'São Paulo'),
(55, 'Mariana Souza', 'Rua C', 5500, 'Vila Formosa', 'São Paulo'),
(56, 'Bruno Santos', 'Rua D', 5600, 'Butantã', 'São Paulo'),
(57, 'Carla Costa', 'Rua E', 5700, 'Barra Funda', 'São Paulo'),
(58, 'Alexandre Ferreira', 'Rua F', 5800, 'Liberdade', 'São Paulo'),
(59, 'Leticia Silva', 'Rua G', 5900, 'Cidade Ademar', 'São Paulo'),
(60, 'Eduardo Oliveira', 'Rua H', 6000, 'São Domingos','São Paulo');

UPDATE alunos SET nome_aluno= 'Fabiana Vitória' WHERE codigo_aluno = 1;
UPDATE alunos SET nome_aluno= 'Maria Fernanda Comenta' WHERE codigo_aluno = 2;


-- Visualiza tabela
SELECT * FROM alunos ORDER BY codigo_aluno;


----------------------------------------------------------------------------------------------------
-- Criação Aluno_pos_graduacao
CREATE TABLE aluno_pos_graduacao(
	codigo_aluno int PRIMARY KEY REFERENCES alunos,
	codigo_orientador int REFERENCES orientadores
);

ALTER TABLE aluno_pos_graducao RENAME TO aluno_pos_graduacao;	

-- Inserindo linhas
INSERT INTO aluno_pos_graducao (codigo_aluno, codigo_orientador) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 5),
(26, 6),
(27, 7),
(28, 8),
(29,9),
(30,10);

-- Visualizar 
SELECT * FROM aluno_pos_graducao;

----------------------------------------------------------------------------------------------------
-- Criação formaçãoEscolar
CREATE TABLE formacao_escolar(
	codigo_aluno int  REFERENCES alunos,
	formacao_escolar varchar(150),
	CONSTRAINT pk_formacao_escolar  PRIMARY KEY (codigo_aluno,formacao_escolar)
);


-- Inserindo linhas
INSERT INTO formacao_escolar VALUES
(1, 'Ciências de Dados'),
(2, 'Bacharelado de Química'),
(3, 'Ciência da computação'),
(4, 'Biomedicina'),
(5, 'Ciências Sociais'),
(6, 'Bacharelado Economia'),
(7, 'Bacharelado em Letras'),
(8, 'Bacharelado Psicologia'),
(9, 'Bacharelado Sociologia'),
(10, 'Bacharelado em Matemática'),
(11, 'Técnologo em Análise e Desenvolvimento de Sistemas'),
(12, 'Técnologo em Análise e Desenvolvimento de Sistemas'),
(13,  'Bacharelado Sociologia'),
(14, 'Ciências Sociais'),
(15, 'Ciências de Dados'),
(16, 'Ciências de Dados'),
(17, 'Ciências de Dados'),
(18, 'Ciências de Dados'),
(19, 'Ciências de Dados'),
(20, 'Ciências de Dados'),
(21, 'Ciência da computação'),
(22, 'Ciência da computação'),
(23, 'Ciência da computação'),
(24, 'Ciência da computação'),
(25, 'Ciência da computação'),
(26, 'Bacharelado em Letras'),
(27, 'Bacharelado em Letras'),
(28, 'Bacharelado em Letras'),
(29, 'Bacharelado em Letras'),
(30, 'Bacharelado em Letras');


-- Visualizar 
SELECT * FROM formacao_escolar;


----------------------------------------------------------------------------------------------------
-- Criação Aluno_graduacao
CREATE TABLE aluno_graduacao(
	codigo_aluno int PRIMARY KEY REFERENCES alunos,
	ano_ingresso int NOT NULL
);


-- Inserindo linhas
INSERT INTO aluno_graduacao (codigo_aluno, ano_ingresso) VALUES
(31, 2020),
(32, 2019),
(33, 2018),
(34, 2021),
(35, 2022),
(36, 2020),
(37, 2019),
(38, 2018),
(39, 2021),
(40, 2022),
(41, 2020),
(42, 2019),
(43, 2018),
(44, 2021),
(45, 2022),
(46, 2020),
(47, 2019),
(48, 2018),
(49, 2021),
(50, 2022),
(51, 2020),
(52, 2019),
(53, 2018),
(54, 2021),
(55, 2022),
(56, 2020),
(57, 2019),
(58, 2018),
(59, 2021),
(60, 2022);


-- Visualizar 
SELECT * FROM aluno_graduacao;

----------------------------------------------------------------------------------------------------
-- Pesquisas no banco de dados


-- 1.1 Quais disciplinas o departamento oferece? Ex: Dep 01
-- Exibir todas as linhas
SELECT * FROM disciplinas WHERE disciplinas.codigo_departamento = 1; 

-- Exibir código do departamento e o nome da disciplina
SELECT codigo_departamento, nome_disciplina 
FROM disciplinas 
WHERE disciplinas.codigo_departamento = 8;

-- Exibir código do departamento, nome e o nome da disciplina
SELECT  departamentos.codigo_departamento,departamentos.nome_departamento, nome_disciplina 
FROM disciplinas INNER JOIN departamentos 
ON departamentos.codigo_departamento = disciplinas.codigo_departamento 
WHERE disciplinas.codigo_departamento = 8;

-- 1.2 Quantas disciplinas o departamento oferece? Ex: Dep 01
SELECT departamentos.codigo_departamento, departamentos.nome_departamento,
		count(codigo_disciplina) 
FROM disciplinas INNER JOIN departamentos USING (codigo_departamento)
GROUP BY departamentos.codigo_departamento
ORDER BY codigo_departamento;


-- 2.1 Quais disciplinas o orientador ministra?
-- Exibindo o departamento do orientador e o departamento da disciplina
SELECT orientadores.nome_orientador, orientadores.codigo_departamento, 
		disciplinas.nome_disciplina,  disciplinas.codigo_departamento 
FROM disciplinas INNER JOIN orientadores USING  (codigo_orientador) 
WHERE disciplinas.codigo_orientador = 1;
-- Exibindo todos os atributos 
SELECT * FROM disciplinas WHERE disciplinas.codigo_orientador = 8

-- 2.2 Quantas disciplinas o orientador ministra?
SELECT orientadores.codigo_orientador, orientadores.nome_orientador,
		count(disciplinas.codigo_disciplina)
FROM disciplinas INNER JOIN orientadores USING  (codigo_orientador)  
GROUP BY orientadores.codigo_orientador ORDER BY codigo_orientador;
-- Forma com o where
SELECT count(codigo_orientador) FROM disciplinas WHERE disciplinas.codigo_orientador = 4;


-- 3.1 Quantas/Quais disciplinas o aluno está matriculado?
SELECT disciplina_aluno.codigo_aluno, alunos.nome_aluno,
		disciplina_aluno.codigo_disciplina, disciplinas.nome_disciplina
FROM disciplinas INNER JOIN disciplina_aluno USING (codigo_disciplina ) 
INNER JOIN alunos USING (codigo_aluno)
WHERE codigo_aluno = 1;
-- 3.2 Quantas disciplinas o aluno está matriculado?
SELECT alunos.codigo_aluno, alunos.nome_aluno, 
		count(disciplina_aluno.codigo_aluno)
FROM disciplinas 
INNER JOIN disciplina_aluno USING (codigo_disciplina ) 
INNER JOIN alunos USING (codigo_aluno)
GROUP BY  alunos.codigo_aluno
ORDER BY alunos.codigo_aluno;


-- 4.1 Os orientadores dos alunos de pós-graduação são do mesmo departamento que eles?
-- Mostrando o departamento do aluno e do orientador
SELECT alunos.nome_aluno, disciplinas.codigo_departamento,
		orientadores.nome_orientador, orientadores.codigo_departamento
FROM orientadores 
INNER JOIN aluno_pos_graduacao USING (codigo_orientador)
INNER JOIN alunos USING (codigo_aluno)
INNER JOIN disciplina_aluno USING (codigo_aluno)
INNER JOIN disciplinas USING (codigo_disciplina);





