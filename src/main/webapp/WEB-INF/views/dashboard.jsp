
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title><c:out value="${pageTitle}" /> | Gestão Financeira</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="dashboard-page">

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand fw-bold"
				href="${pageContext.request.contextPath}/"> Gestão Financeira </a> <a
				class="btn btn-outline-light btn-sm"
				href="${pageContext.request.contextPath}/"> Página inicial </a>
		</div>
	</nav>

	<main class="container py-5">
		<div class="mb-4">
			<h1 class="h2 fw-bold">
				<c:out value="${pageTitle}" />
			</h1>

			<p class="text-secondary">Visão geral das suas finanças pessoais.
			</p>
		</div>

		<div class="row g-4">
			<div class="col-md-4">
				<div class="card financial-card income-card h-100">
					<div class="card-body">
						<p class="text-secondary mb-2">Total de receitas</p>
						<h2 class="h3">R$ 0,00</h2>
						<span class="small">Receitas do período</span>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card financial-card expense-card h-100">
					<div class="card-body">
						<p class="text-secondary mb-2">Total de despesas</p>
						<h2 class="h3">R$ 0,00</h2>
						<span class="small">Despesas do período</span>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card financial-card balance-card h-100">
					<div class="card-body">
						<p class="text-secondary mb-2">Saldo atual</p>
						<h2 class="h3">R$ 0,00</h2>
						<span class="small">Saldo demonstrativo</span>
					</div>
				</div>
			</div>
		</div>

		<div class="card border-0 shadow-sm mt-4">
			<div class="card-body p-4">
				<h2 class="h5">Próximas funcionalidades</h2>

				<ul class="mb-0">
					<li>Cadastro de categorias financeiras.</li>
					<li>Lançamento de receitas e despesas.</li>
					<li>Contas a pagar e a receber.</li>
					<li>Relatórios financeiros.</li>
				</ul>
			</div>
		</div>
	</main>

	<footer class="py-4 text-center text-secondary"> Sistema de
		Gestão Financeira Pessoal </footer>

</body>
</html>
