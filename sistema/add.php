<?php
require_once 'db.php';

// Verifica se o formulário foi enviado via POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Prepara a query SQL para inserção. Usar placeholders (ex: :nome) previne SQL Injection.
    $sql = "INSERT INTO equipamentos (nome, tipo, ip_gerenciamento, localizacao) VALUES (:nome, :tipo, :ip, :local)";
    $stmt = $pdo->prepare($sql);

    // Associa os valores do formulário aos placeholders da query
    $stmt->execute([
        ':nome' => $_POST['nome'],
        ':tipo' => $_POST['tipo'],
        ':ip'   => $_POST['ip_gerenciamento'],
        ':local'=> $_POST['localizacao']
    ]);

    // Redireciona o usuário de volta para a página inicial
    header("Location: index.php");
    exit;
}