<?php
require_once 'db.php';

$id = $_GET['id'] ?? null;
if (!$id) {
    header('Location: index.php');
    exit;
}

// Busca o equipamento pelo ID
$stmt = $pdo->prepare('SELECT * FROM equipamentos WHERE id = ?');
$stmt->execute([$id]);
$equipamento = $stmt->fetch();

if (!$equipamento) {
    echo "Equipamento não encontrado!";
    exit;
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Equipamento</title>
    <style> /* Estilos iguais ao create.php */
        body { font-family: sans-serif; margin: 2em; }
        form { max-width: 500px; }
        label, input { display: block; margin-bottom: 10px; width: 100%; }
        input[type="submit"] { width: auto; padding: 10px 20px; background-color: #007bff; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <h1>Editar Equipamento</h1>
    <form action="update.php" method="post">
        <input type="hidden" name="id" value="<?= $equipamento['id'] ?>">

        <label for="nome">Nome:</label>
        <input type="text" name="nome" id="nome" value="<?= htmlspecialchars($equipamento['nome']) ?>" required>

        <label for="tipo">Tipo:</label>
        <input type="text" name="tipo" id="tipo" value="<?= htmlspecialchars($equipamento['tipo']) ?>" required>

        <label for="ip_gerenciamento">IP de Gerenciamento:</label>
        <input type="text" name="ip_gerenciamento" id="ip_gerenciamento" value="<?= htmlspecialchars($equipamento['ip_gerenciamento']) ?>">

        <label for="localizacao">Localização:</label>
        <input type="text" name="localizacao" id="localizacao" value="<?= htmlspecialchars($equipamento['localizacao']) ?>">

        <input type="submit" value="Atualizar">
    </form>
</body>
</html>