import 'dart:io';

/// Obtém o número de processos em execução.
///
/// Executa o processo de tasklist do sistema filtrando o parâmetro IMAGENAME
/// para exibir somente os valores identicos ao argumento [process]. O ideal é
/// passar o nome do processo por complexo, ex: "discord.exe", ao invés somente
/// de "discord", isso porque pode existir outros processos que contenham partes
/// da string em seu nome, ex: "discord_update.exe".
///
/// Caso ocorra qualquer problema na execução do sistema, uma [Exception]
/// será lançada contendo o código retornado pelo processo e o [stderr].
///
Future<int> countProcessByName(String process) async {
  var execution = await Process.run(
    'tasklist',
    ['/FI', 'IMAGENAME eq $process'],
  );

  if (execution.exitCode != 0)
    throw Exception(
      "Fail to run the tasklist process. Code: ${execution.exitCode} - Err: ${execution.stderr}",
    );

  var counter = 0;
  process = process.toLowerCase();

  for (var line in execution.stdout.toString().split('\n')) {
    if (line.toLowerCase().contains(process)) counter++;
  }

  return counter;
}
