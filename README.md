# Desafio_projeto_logico_Oficina
Projeto do sistema de uma Oficina, relacionado as Ordens de Serviços (OS) que ela realiza. Realizado desde o modelo EER até o projeto lógico do BD. Desafio do BootCamp da DIO "Suzano - Analise de dados com Power BI"

O objetivo desafio desse projeto consistia em fazer do 0, desde o conceito até o banco de dados do Sistema de Gerenciamento de OS de uma oficina, visando aprimorar os conhecimentos acerca de banco de dados e linguagem SQL,
Além de procurar a maior eficiência do sistema em geral.
Não existia muitas descrições acerca do contexto do sistema, então grande parte veio de ideias próprias, porém, dentro de algumas especificações dentro do contexto, havia:

- Um mecânico compunha uma equipe
- veículos eram alocados a uma equipe apenas
- a equipe tanto preenche a OS, quanto a executa

Fora essas especificações, todo o resto do sistema tirei algumas ideias para adicionar, como:

-tabela acerca dos serviços prestados
-tabela das peças da oficina
-aloquei cada veiculo exclusivamente a uma OS, para encontrá-lo com facilidade nas queries
-clientes poderiam ter mais de um veículo relacionado

Por se tratar de uma oficina, deixei os dados dos clientes simples, apenas com alguns dados mais genéricos de cadastros no geral;

após toda a montagem do modelo EER, parti para a criação do banco, o qual o script está disponível.

A descrição das queries, das perguntas que elas procuram responder, estão também presentes no próprios comentários do script.
