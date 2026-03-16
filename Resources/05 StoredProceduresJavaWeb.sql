CREATE DATABASE StoredProceduresJavaWeb
GO
USE StoredProceduresJavaWeb

CREATE TABLE  cliente (
cpf CHAR(11) NOT NULL,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
limite_de_credito DECIMAL(7,2) NOT NULL,
dt_nascimento  DATE NOT NULL
PRIMARY KEY(cpf)
)

CREATE PROCEDURE sp_validaRepeticao (@cpf CHAR(11), @valido BIT OUTPUT)
AS
	IF (@cpf = '00000000000' OR @cpf = '11111111111' 
		OR @cpf = '22222222222' OR @cpf = '33333333333' 
		OR @cpf = '44444444444' OR @cpf = '55555555555' 
		OR @cpf = '66666666666' OR @cpf = '77777777777' 
		OR @cpf = '88888888888' OR @cpf = '99999999999')
	BEGIN
		SET @valido = 0
	END
	ELSE 
	BEGIN
		SET @valido  = 1
	END


CREATE PROCEDURE sp_validaCPF(@cpf CHAR(11), @valido BIT OUTPUT)
AS 
	DECLARE @valido_cpfRepet BIT,
	@soma int,
	@digito1 int,
	@digito2 int,
	@cont int
	SET @soma = 0
	SET @cont =  1
	
	EXEC sp_validaRepeticao @cpf, @valido_cpfRepet OUTPUT
	IF (@valido_cpfRepet = 0)
	BEGIN
		SET @valido = 0 
		return
	END

	WHILE (@cont < 10)
	BEGIN
		SET @soma = @soma + (CAST(SUBSTRING(@cpf,@cont,1) as INT) * (11 - @cont))
		SET  @cont = @cont + 1
	END
	IF (@soma % 11 < 2)
	BEGIN
		SET @digito1 = 0
	END
	ELSE
	BEGIN 
		SET @digito1 = 11 - @soma % 11
	END

	IF (@digito1 = CAST(SUBSTRING(@cpf,10,1) AS INT))
	BEGIN
		SET @valido = 1
	END
	ELSE 
	BEGIN
		SET @valido  = 0
	END

	SET @soma = 0
	SET @cont = 1
	
	WHILE (@cont < 11)
	BEGIN
		SET @soma = @soma + (CAST(SUBSTRING(@cpf,@cont,1) as INT) * (12 - @cont))
		SET  @cont = @cont + 1
	END
	IF (@soma % 11 < 2)
	BEGIN
		SET @digito2 = 0
	END
	ELSE 
	BEGIN
		SET @digito2 = 11 - @soma % 11
	END

	IF (@digito2 = CAST(SUBSTRING(@cpf,11,1) AS INT))
	BEGIN
		SET @valido = 1
	END
	ELSE 
	BEGIN
		SET @valido  = 0
	END

CREATE PROCEDURE sp_cliente(@cod CHAR(1), @cpf CHAR(11), 
	@nome VARCHAR(100), @email VARCHAR(100), @limite DECIMAL(7,2),
	@nasc DATE, @output VARCHAR(100) OUTPUT)
AS
	DECLARE @valido_cpf BIT
	IF (UPPER(@cod) = 'D' AND  @cpf IS NOT NULL)
	BEGIN
		DELETE cliente WHERE cpf = @cpf
		SET @output = @cpf + ' excluído com sucesso'
	END
	ELSE
	BEGIN
		IF (UPPER(@cod) = 'D' AND  @cpf IS NULL)
		BEGIN
		RAISERROR('CPF Inválido', 16, 1)
		END
		IF (@cod = 'I')
		BEGIN
			EXEC sp_validaCPF @cpf, @valido_cpf OUTPUT
			IF (@valido_cpf = 1)
			BEGIN 
				INSERT INTO cliente VALUES (@cpf, @nome,
					@email, @limite, @nasc)
				SET @output = @cpf + ' inserido com sucesso'
			END
			ELSE 
			BEGIN
				RAISERROR ('CPF Inválido', 16, 1)
			END
		END
		ELSE
		BEGIN
			IF (UPPER(@cod)= 'U')
			BEGIN
				DECLARE @existe CHAR(11)
				SELECT @existe = cpf FROM cliente
				WHERE cpf = @cpf
				IF @existe IS NULL
				BEGIN
				    RAISERROR('Cliente não encontrado',16,1)
				END
				ELSE 
				BEGIN
					UPDATE cliente SET nome = @nome, email = @email,
						limite_de_credito = @limite, dt_nascimento = @nasc
					WHERE cpf = @cpf
					SET @output = @cpf + ' alterado com sucesso'
				END
			END
			ELSE
			BEGIN
				RAISERROR('Operacao invalida', 16, 1)
			END
		END
	END
