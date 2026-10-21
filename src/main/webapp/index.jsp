
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Gestão Financeira Pessoal</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="landing-page">

	<nav class="navbar navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand fw-bold"
				href="${pageContext.request.contextPath}/"> Gestão Financeira </a>
		</div>
	</nav>

	<main class="container py-5">
		<div class="row align-items-center min-vh-75">
			<div class="col-lg-7">
				<span class="badge text-bg-primary mb-3"> Organização
					financeira </span>

				<h1 class="display-5 fw-bold">Assuma o controle das suas
					finanças.</h1>

				<p class="lead text-secondary mt-3">Organize receitas, despesas
					e contas em um único lugar. Acompanhe sua evolução financeira com
					praticidade.</p>

				<a class="btn btn-primary btn-lg mt-3"
					href="${pageContext.request.contextPath}/inicio"> Acessar
					dashboard </a>
			</div>

			<div class="col-lg-5 mt-5 mt-lg-0">
				<div class="card shadow border-0">
					<div class="card-body p-4">
						<h2 class="h5 mb-4">Resumo financeiro</h2>

						<div class="summary-item income">
							<span>Receitas</span> <strong>R$ 0,00</strong>
						</div>

						<div class="summary-item expense">
							<span>Despesas</span> <strong>R$ 0,00</strong>
						</div>

						<hr>

						<div class="d-flex justify-content-between">
							<span class="fw-semibold">Saldo</span> <strong>R$ 0,00</strong>
						</div>

						<p class="text-secondary small mt-3 mb-0">Valores
							ilustrativos. Os dados reais serão carregados nas próximas
							etapas.</p>
					</div>
				</div>
			</div>
		</div>
	</main>

	<footer class="py-4 text-center text-secondary">
		<div class="container">Sistema de Gestão Financeira Pessoal</div>
	</footer>

</body>
</html>
