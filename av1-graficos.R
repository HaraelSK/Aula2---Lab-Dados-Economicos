# WORLD DEVELOPMENT INDICATORS (WDI)

#install.packages("WDI")
#install.packages('tidyverse')
library(tidyverse)
library(WDI) # CARREGAR BIBLIOTECA/PACOTE
library(ggplot2) # Carregar ggplot2
library(scales) # Para formatação de números

options(scipen = 999) # REMOVER A NOT. CIENT.
# DADOS EM PAINEL

paises_emergentes <- c('BR', 'CN', 'IN', 'MX', 'ID', 'TR', 'ZA', 'AR', 'NG', 'EG', 'PK', 'BD', 'PH', 'VN', 'TH', 'CO')

dados_divida_externa <- WDI(country = paises_emergentes,
                            indicator = 'DT.DOD.DECT.CD',
                            start = 2000, end = 2023) %>%
  rename(ano = year, divida_usd = DT.DOD.DECT.CD, pais = country)

# CORTE TRANSVERSAL
dados_divida_externa_2023 <- WDI(country = paises_emergentes,
                                 indicator = 'DT.DOD.DECT.CD',
                                 start = 2023, end = 2023) %>%
  rename(divida_usd = DT.DOD.DECT.CD, pais = country)

# SÉRIE TEMPORAL
dados_divida_externa_br <- WDI(country = 'BR',
                               indicator = 'DT.DOD.DECT.CD',
                               start = 1980, end = 2023) %>%
  rename(ano = year, divida_usd = DT.DOD.DECT.CD)

## GRÁFICOS COM GGPLOT2

# TEMA MODERNO SIMPLES
tema_moderno <- theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "bottom",
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    axis.text.y = element_text(size = 10), # Aplicar formatação no texto do eixo y
    axis.text.x = element_text(size = 10),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank()
  )

# Função para formatar os valores em dólar
format_usd_abbreviated <- function(x) {
  ifelse(x >= 1e9, paste0("U$", round(x / 1e9, 1), " bi"),
         ifelse(x >= 1e6, paste0("U$", round(x / 1e6, 1), " mi"),
                ifelse(x >= 1e3, paste0("U$", round(x / 1e3, 1), " mil"),
                       paste0("U$", x))))
}

# DADOS EM PAINEL

dados_divida_externa$pais <- factor(dados_divida_externa$pais)

dados_brasil <- dados_divida_externa %>% filter(pais == "Brazil")
dados_outros <- dados_divida_externa %>% filter(pais != "Brazil")

grafpainel_divida <- ggplot() +
  # Camada: outros países (ao fundo)
  geom_line(data = dados_outros, aes(x = ano, y = divida_usd, group = pais),
            color = "steelblue", linewidth = 0.7, alpha = 0.5) +
  geom_point(data = dados_outros, aes(x = ano, y = divida_usd, group = pais),
             color = "steelblue", size = 1.5, alpha = 0.5) +
  
  # Camada: Brasil (por cima)
  geom_line(data = dados_brasil, aes(x = ano, y = divida_usd),
            color = "red", linewidth = 1.5) +
  geom_point(data = dados_brasil, aes(x = ano, y = divida_usd),
             color = "red", size = 3) +
  
  scale_y_continuous(labels = format_usd_abbreviated) + # Aplicar formatação no eixo y
  labs(
    title = "Evolução da Dívida Externa (US$ Corrente) em Países Emergentes",
    x = "Ano",
    y = "Dívida Externa",
    caption = "Valores em U$ (bi, mi, mil)" # Adicionar legenda para a abreviação
  ) +
  tema_moderno

print(grafpainel_divida)

# CORTE TRANSVERSAL (Gráfico de Barras para melhor comparação em um único ano)
grafcorte_divida_2023 <- ggplot(dados_divida_externa_2023,
                                aes(x = pais,
                                    y = divida_usd)) +
  geom_col(fill = 'steelblue') +
  scale_y_continuous(labels = format_usd_abbreviated) + # Aplicar formatação no eixo y
  labs(
    title = "Dívida Externa (US$ Corrente) em Países Emergentes em 2023",
    x = "País",
    y = "Dívida Externa",
    caption = "Valores em U$ (bi, mi, mil)" # Adicionar legenda para a abreviação
  ) +
  tema_moderno +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotacionar rótulos do eixo x para melhor leitura

print(grafcorte_divida_2023)

# SÉRIE TEMPORAL (Apenas para o Brasil, já que os outros países estão no gráfico de painel)
grafserie_divida_br <- ggplot(dados_divida_externa_br,
                              aes(y = divida_usd,
                                  x = ano)) +
  geom_line(color = "red", linewidth = 1.2) +
  geom_point(color = "red", size = 3) +
  scale_y_continuous(labels = format_usd_abbreviated) + # Aplicar formatação no eixo y
  labs(
    title = "Série Temporal da Dívida Externa do Brasil (US$ Corrente)",
    x = "Ano",
    y = "Dívida Externa",
    caption = "Valores em U$ (bi)" # Adicionar legenda para a abreviação
  ) +
  tema_moderno

print(grafserie_divida_br)
