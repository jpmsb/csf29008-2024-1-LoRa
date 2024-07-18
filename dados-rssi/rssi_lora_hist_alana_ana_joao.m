clc; clear all; close all;

% Data mínima
data_inicial = datenum('07/18/2024 14:38:00', 'mm/dd/yyyy HH:MM:SS');

% Abre o arquivo para leitura
arquivo = 'dados_tratados_alana_ana_joao.csv';
fid = fopen(arquivo, 'r');

% Lê a primeira linha do arquivo
cabecalho = fgetl(fid);

% Lê o arquivo CSV inteiro
dados = textscan(fid, '%s %s', 'Delimiter', ',', 'HeaderLines', 1);

% Fecha o arquivo após a leitura
fclose(fid);

% Separa os dados em duas variáveis
data_e_horario_str = dados{1}; % Primeira coluna
rssis_str = dados{2};          % Segunda coluna

% Remoção das aspas
data_e_horario_str = strrep(data_e_horario_str, '"', '');
rssis_str = strrep(rssis_str, '"', '');

% Converter a data e o horário para o formato de data
data_e_horario = datenum(data_e_horario_str, 'mm/dd/yyyy HH:MM:SS AM');

% Filtrar os dados a partir da data mínima
filtro_indice = data_e_horario >= data_inicial;
data_e_horario_partida = data_e_horario(filtro_indice);
rssis_str_partida = rssis_str(filtro_indice);

% Converter RSSI para número
rssis = str2double(rssis_str_partida);

% Eliminar valores NaN
rssis = rssis(~isnan(rssis));

% Laço que obtém a quantidade de ocorrências de cada RSSI
for i = 1:length(rssis)
   rssi = rssis(i);
   if ~exist('ocorrencias', 'var')
      ocorrencias = zeros(1, 1);
      rssis_unicos = zeros(1, 1);
   end
   if ~any(rssi == rssis_unicos)
      rssis_unicos = [rssis_unicos, rssi];
      ocorrencias = [ocorrencias, 1];
   else
      indice = find(rssi == rssis_unicos);
      ocorrencias(indice) = ocorrencias(indice) + 1;
   end
end

% Ordenar os RSSIs únicos
[rssis_unicos, indices] = sort(rssis_unicos);
ocorrencias_contagem = ocorrencias(indices);
ocorrencias_contagem = ocorrencias_contagem(1:end-1);

% Obtendo a quantidade de ocorrências de cada RSSI pela função HIST
[ocorrencias_hist, rssis_unicos] = hist(rssis, unique(rssis));

% Exibir os resultados de forma formatada
disp('RSSI Único | Ocorrências contagem | Ocorrências hist');
disp([rssis_unicos', ocorrencias_contagem', ocorrencias_hist']);

% Medições totais
total_medicoes = length(rssis);
disp(['Total de medições desde ', datestr(data_inicial, 'dd/mm/yyyy'), ': ', num2str(total_medicoes)]);

% Gráfico de barras
hist(rssis, 100);
title('RSSI LoRa (Alana, Ana, João)');
xlabel('RSSI');
ylabel('Frequência');
grid on;
