<?php
// Arquivo de configuração e conexão com o banco de dados

$host = '10.0.0.5';         
$dbname = 'meuprojeto';
$user = 'appuser';
$pass = 'Meu49854Proje7o';
$charset = 'utf8mb4';

// DSN (Data Source Name) - define a conexão
$dsn = "mysql:host=$host;dbname=$dbname;charset=$charset";

// Opções do PDO para um comportamento mais seguro e útil
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION, // Lança exceções em caso de erro
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,       // Retorna os resultados como arrays associativos
    PDO::ATTR_EMULATE_PREPARES   => false,                  // Desabilita a emulação de prepared statements para segurança
];

try {
    // Cria a instância do PDO para a conexão
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    // Em caso de erro na conexão, exibe uma mensagem e encerra o script
    // Em um ambiente de produção, seria melhor logar o erro em vez de exibi-lo
    throw new \PDOException($e->getMessage(), (int)$e->getCode());
}