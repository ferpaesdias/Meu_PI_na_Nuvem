<?php
require_once 'db.php';

// Prepara e executa a query para selecionar todos os equipamentos
$stmt = $pdo->query('SELECT * FROM equipamentos ORDER BY nome ASC');
$equipamentos = $stmt->fetchAll();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Gerenciador de Equipamentos de Rede</title>
    <style>
        body { font-family: sans-serif; margin: 2em; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        a { text-decoration: none; color: #007bff; }
        .action-links a { margin-right: 10px; }
        .add-link { display: inline-block; margin-bottom: 20px; padding: 10px 15px; background-color: #28a745; color: white; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>Equipamentos de Rede</h1>
    <a href="create.php" class="add-link">Adicionar Novo Equipamento</a>
    <table>
        <thead>
            <tr>
                <th>Nome</th>
                <th>Tipo</th>
                <th>IP de Gerenciamento</th>
                <th>Localização</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($equipamentos as $equipamento): ?>
            <tr>
                <td><?= htmlspecialchars($equipamento['nome']) ?></td>
                <td><?= htmlspecialchars($equipamento['tipo']) ?></td>
                <td><?= htmlspecialchars($equipamento['ip_gerenciamento']) ?></td>
                <td><?= htmlspecialchars($equipamento['localizacao']) ?></td>
                <td class="action-links">
                    <a href="edit.php?id=<?= $equipamento['id'] ?>">Editar</a>
                    <a href="delete.php?id=<?= $equipamento['id'] ?>" onclick="return confirm('Tem certeza que deseja excluir este item?');">Excluir</a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>