import pandas as pd
import folium
from folium.plugins import HeatMap

# Passo 1: Carregar os dados em um DataFrame do pandas
data = pd.read_csv('mapa.csv')  # Substitua 'seu_arquivo.csv' pelo nome do seu arquivo de dados

# Passo 2: Preparar os dados para o heatmap
# Certifique-se de que as colunas estão nomeadas corretamente
# Este exemplo assume que seu DataFrame tem colunas 'latitude', 'longitude' e 'rssi'
heat_data = [[row['latitude'], row['longitude'], row['rssi']] for index, row in data.iterrows()]

# Passo 3: Criar o mapa base
mapa = folium.Map(location=[-27.608121, -48.632408], zoom_start=20)  # Substitua latitude_central e longitude_central pelos valores centrais dos seus dados

# Passo 4: Adicionar o heatmap ao mapa
HeatMap(heat_data).add_to(mapa)

# Passo 5: Salvar o mapa em um arquivo HTML
mapa.save('mapa_de_calor.html')
