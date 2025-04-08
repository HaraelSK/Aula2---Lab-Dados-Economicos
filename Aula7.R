# WORLD DEVELOPMENT INDICATORS (WDI)
# INDICADORES DE DESENVOLVIMENTO MUNDIAL

# PIB (PRODUTO INTERNO BRUTO)

#install.packages('WDI')
#library(WDI)

options(scipen = 999)

# DADOS EM PAINEL
dadospib <- WDI(country = 'all',
                indicator = 'NY.GDP.MKTP.CD')

paises <- c('BR', 'US')

dadospibbrus <- WDI(country = paises,
                    indicator = 'NY.GDP.MKTP.CD')

# CORTE TRANSVERSAL
dadospib2023 <- WDI(country = 'all',
                    indicator = 'NY.GDP.MKTP.CD',
                    start = 2023, end = 2023)

# SÉRIE TEMPORAL
dadospibbr <- WDI(country = 'BR',
                  indicator = 'NY.GDP.MKTP.CD')
dadospibus <- WDI(country = 'US', 
                  indicator = 'NY.GDP.MKTP.CD')

# GRÁFICOS

# BIBLIOTECA ggplot2 (tidyverse)
#install.packages("tidyverse")
#library(tidyverse)

## DADOS EM PAINEL

grafpainel <- ggplot(data = dadospib, 
                     mapping = aes(x = year, y = NY.GDP.MKTP.CD)) +
  # Todos os países com pontos em azul
  geom_point(aes(color = "Outros Países"), alpha = 0.4) +  
  # Brasil em destaque (vermelho)
  geom_point(data = filter(dadospib, country == "Brazil"),
             aes(color = "Brasil"), size = 2) +
  # Título e rótulos dos eixos
  labs(title = "PIB ao Longo do Tempo",
       x = "Ano",
       y = "PIB (US$ corrente)") +
  # Definir as cores para a legenda
  scale_color_manual(values = c("Brasil" = "red", "Outros Países" = "blue"), 
                     guide = "legend") +  # Removendo o título "color"
  # Tema mais moderno
  theme_minimal(base_family = "Helvetica") +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.position = "bottom",  # Colocando a legenda na parte inferior
    legend.justification = "center",  # Centralizando a legenda
    legend.title = element_blank()  # Removendo o título da legenda
  )

# Exibindo o gráfico de dados em painel
print(grafpainel)

# CORTE TRANSVERSAL (Dados de 2023)

grafcorte <- ggplot(dadospib2023,
                    mapping = aes(y = NY.GDP.MKTP.CD,
                                  x = year)) +  
  # Todos os países com pontos em azul
  geom_point(aes(color = "Outros Países"), alpha = 0.4) +  
  # Brasil em destaque (vermelho)
  geom_point(data = filter(dadospib2023, country == "Brazil"),
             aes(color = "Brasil"), size = 2) +
  labs(title = "PIB de Todos os Países em 2023",
       x = "Ano",
       y = "PIB (em USD)") +  # Título e labels
  scale_color_manual(values = c("Brasil" = "red", "Outros Países" = "blue"), 
                     guide = "legend") +  # Removendo o título "color"
  theme_minimal() +  # Tema minimalista
  theme(
    text = element_text(family = "Arial", size = 12),  # Fonte moderna
    legend.position = "bottom",  # Colocando a legenda na parte inferior
    legend.justification = "center",  # Centralizando a legenda
    plot.title = element_text(hjust = 0.5),  # Centralizando o título
    legend.title = element_blank()  # Removendo o título da legenda
  )

# Exibindo o gráfico de corte transversal
print(grafcorte)

# SÉRIE TEMPORAL (Brasil com destaque)

# Alterando para incluir o Brasil em vermelho
grafserie <- ggplot() +
  geom_line(data = dadospibbr, aes(x = year, y = NY.GDP.MKTP.CD, color = "Brasil"), size = 1.2) +  # Linha do Brasil
  geom_line(data = dadospibbr[dadospibbr$country != "BR", ], aes(x = year, y = NY.GDP.MKTP.CD, color = "Outros Países"), alpha = 0.6) +  # Linha de outros países
  labs(title = "Série Temporal do PIB do Brasil",
       x = "Ano",
       y = "PIB (em USD)") +
  scale_color_manual(values = c("Brasil" = "red"), 
                     guide = "legend") +  # Removendo o título "color"
  theme_minimal() +
  theme(
    text = element_text(family = "Arial", size = 12),  # Fonte moderna
    plot.title = element_text(hjust = 0.5),  # Centralizando o título
    legend.position = "bottom",  # Colocando a legenda na parte inferior
    legend.justification = "center",  # Centralizando a legenda
    legend.title = element_blank()  # Removendo o título da legenda
  )

# Exibindo o gráfico da série temporal
print(grafserie)
