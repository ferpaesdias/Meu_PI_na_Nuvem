<?php
require_once 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $sql = "UPDATE equipamentos SET nome = :nome, tipo = :tipo, ip_gerenciamento = :ip, localizacao = :local WHERE id = :id";
    $stmt = $pdo->prepare($sql);

    $stmt->execute([
        ':id'   => $_POST['id'],
        ':nome' => $_POST['nome'],
        ':tipo' => $_POST['tipo'],
        ':ip'   => $_POST['ip_gerenciamento'],
        ':local'=> $_POST['localizacao']
    ]);

    header("Location: index.php");
    exit;
}