# INSTALAR OS PACOTES (descomente para instalar se ainda não o fez)
# install.packages("GetBCBData")
# install.packages("tidyverse")
# install.packages("gganimate")
# install.packages("gifski") 

# CARREGAR AS BIBLIOTECAS
library(GetBCBData)
library(tidyverse)
library(gganimate)
library(gifski)

# OS CÓDIGOS DAS VARIÁVEIS VÊM DIRETO DA PLATAFORMA
# ACESSAR O SGS
# http://www.bcb.gov.br/?sgs

my.id <- c(resultado_SC = 15444)

df.bcb <- gbcbd_get_series(id = my.id ,
                           first.date = '2008-03-01', # Ajustado para a data da imagem
                           last.date = '2024-12-31', # Ajustado para a data da imagem (4º Trim. 2024)
                           format.data = 'long',
                           use.memoise = TRUE,
                           cache.path = tempdir(), # use tempdir for cache folder
                           do.parallel = FALSE)

glimpse(df.bcb)

# GRÁFICO ANIMADO COM TEMA MINIMALISTA E MODERNO
graf_animado <- ggplot(df.bcb, aes(x = ref.date, y = value) ) +
  geom_line(color = "#3498DB", size = 1.2) + # Cor azul moderna e espessura ligeiramente maior
  geom_point(color = "#E74C3C", size = 2, alpha = 0.8) + # Cor vermelha para destaque, com leve transparência
  labs(title = 'Resultado primário do Governo do Estado de SC', # Título mais conciso
       subtitle = paste0(format(min(df.bcb$ref.date), "%d/%m/%Y"), ' até ', format(max(df.bcb$ref.date), "%d/%m/%Y")), # Subtítulo formatado
       x = '', y = 'R$ (milhões)') +
  theme_minimal() + # Ponto de partida minimalista
  theme(
    # Títulos e textos
    plot.title = element_text(size = 18, face = "bold", color = "#2C3E50", hjust = 0), # Título em negrito, cor escura, alinhado à esquerda
    plot.subtitle = element_text(size = 12, color = "#7F8C8D", hjust = 0, margin = margin(b = 10)), # Subtítulo mais discreto, cor cinza, margem inferior
    axis.title.y = element_text(size = 10, color = "#7F8C8D", margin = margin(r = 10)), # Título do eixo Y, cor cinza
    axis.text = element_text(size = 9, color = "#7F8C8D"), # Texto dos eixos, cor cinza
    
    # Grades e linhas
    panel.grid.major = element_line(color = "#ECF0F1", linewidth = 0.5), # Grades principais muito claras
    panel.grid.minor = element_blank(), # Remove grades secundárias
    panel.background = element_rect(fill = "white", color = NA), # Fundo branco sem borda
    plot.background = element_rect(fill = "white", color = NA), # Fundo geral branco sem borda
    axis.line = element_line(color = "#BDC3C7", linewidth = 0.4), # Linhas de eixo finas e cinza claro
    axis.ticks = element_line(color = "#BDC3C7", linewidth = 0.4), # Ticks dos eixos finos e cinza claro
    
    # Outros elementos
    plot.margin = margin(10, 10, 10, 10) # Margem geral do plot
  ) +
  transition_reveal(ref.date) 

# Para salvar o GIF, você pode usar a função animate e depois anim_save
# Ajustes para uma animação mais suave:
my_fps <- 30
my_nframes <- nrow(df.bcb) * 5

animate(graf_animado, nframes = my_nframes, fps = my_fps, renderer = gifski_renderer())

# Você pode salvar o GIF em um arquivo, por exemplo:
# anim_save("resultado_sc_animado_minimalista.gif"
