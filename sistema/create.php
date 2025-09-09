<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Adicionar Equipamento</title>
    <style>
        body { font-family: sans-serif; margin: 2em; }
        form { max-width: 500px; }
        label, input { display: block; margin-bottom: 10px; width: 100%; }
        input[type="submit"] { width: auto; padding: 10px 20px; background-color: #007bff; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <h1>Adicionar Novo Equipamento</h1>
    <form action="add.php" method="post">
        <label for="nome">Nome:</label>
        <input type="text" name="nome" id="nome" required>

        <label for="tipo">Tipo (ex: Roteador, Switch, Firewall):</label>
        <input type="text" name="tipo" id="tipo" required>

        <label for="ip_gerenciamento">IP de Gerenciamento:</label>
        <input type="text" name="ip_gerenciamento" id="ip_gerenciamento">

        <label for="localizacao">Localização (ex: Rack 01 - Lab Redes):</label>
        <input type="text" name="localizacao" id="localizacao">

        <input type="submit" value="Salvar">
    </form>
</body>
</html>