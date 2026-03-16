<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cliente</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-OaVG6prZf4v69dPg6PhVattBXkcOWQB62pdZ3ORyrao=" crossorigin="anonymous"></script>
</head>
<body>
	<br />
	<div class="conteiner" align="center">
		<h1>Cadastro de Clientes</h1>
		<br />
		<form action="cliente" method ="post"> 
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan = "3">
						<input type = "text" name ="cpf" maxlength="11" pattern="\d{11}" id ="cpf" placeholder="CPF" value='<c:out value = "${cliente.cpf }" />'>				
					</td>
					<td>
						<input type = "submit" id ="botao" name="botao" value="Buscar" class="btn btn-secondary">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan = "4">
						<input type = "text" name = "nome" id = "nome" placeholder = "Nome" value='<c:out value = "${cliente.nome }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan = "4">
						<input type = "text" name = "email" id = "email" placeholder = "Email" value='<c:out value = "${cliente.email }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan = "4">
						<input type = "number" min = "0" step ="0.01" name = "limite" id = "limite" placeholder = "Limite de Crédito" value='<c:out value = "${cliente.limite }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan = "4">
						<input type = "date" name = "dtNasc" id = "dtNasc" placeholder = "Data de Nascimento" value='<c:out value = "${cliente.dtNasc }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type = "submit" id ="botao" name="botao" value="Inserir" class="btn btn-secondary"></td>
					<td><input style="margin: 0 2px;" type = "submit" id ="botao" name="botao" value="Alterar" class="btn btn-secondary"></td>
					<td><input style="margin: 0 2px;" type = "submit" id ="botao" name="botao" value="Excluir" class="btn btn-secondary"></td>
					<td><input style="margin: 0 2px;" type = "submit" id ="botao" name="botao" value="Listar" class="btn btn-secondary"></td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<div class = "conteiner" align = "center">
		<c:if test ="${not empty saida}">
			<h2 style = "color: green;"><c:out value="${saida }" /></h2>
		</c:if>
	</div>
	
	<div class = "conteiner" align = "center">
		<c:if test ="${not empty erro}">
			<h2 style = "color: red;"><c:out value="${erro }" /></h2>
		</c:if>
	</div>
	
	<div class = "conteiner" align = "center">
		<c:if test ="${not empty clientes}">
			<table class = "table table-secondary table-striped-columns">
				<thead>
					<tr>
						<th>CPF</th>
						<th>Nome</th>
						<th>E-mail</th>
						<th>Limite Cred</th>
						<th>Data Nasc </th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${clientes }">
						<tr>
							<td>${c.cpf }</td>
							<td>${c.nome }</td>
							<td>${c.email }</td>
							<td>${c.limite }</td>
							<td>${c.dtNasc }</td>
							<td><a href="${pageContext.request.contextPath }/cliente?acao=editar&cpf=${c.cpf}">EDITAR</a></td>
							<td><a href="${pageContext.request.contextPath }/cliente?acao=excluir&cpf=${c.cpf}">EXCLUIR</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>