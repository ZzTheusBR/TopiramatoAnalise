# O topiramato é um fármaco anticonvulsivante utilizado no tratamento de epilepsia, enxaqueca e transtornos bipolares.
# Lendo o arquivo 'dados_tratados.csv' diretamente da pasta atual
arq <- read.table(file = "dados_tratados.csv", header = TRUE, sep = ",")
# Visualizando o dataframe 'arq'
View(arq)

# Variáveis: PRINCIPIO_ATIVO; SEXO; IDADE; UF_VENDA; MES_VENDA
# PRINCIPIO_ATIVO: Refere-se ao princípio ativo do medicamento, que é a substância responsável pelo efeito. Qualitativa nominal.
# SEXO: Indica o sexo da pessoa que comprou o medicamento, podendo ser masculino ou feminino. Qualitativa nominal.
# IDADE: Representa a idade da pessoa que comprou o medicamento, expressa em anos. Quantitativa discreta.
# UF_VENDA: Refere-se ao estado em que o medicamento foi vendido, utilizando a sigla do estado. Qualitativa nominal.
# MES_VENDA: Indica o mês em que o medicamento foi vendido, representado por um número de 1 a 11 (o mês de dezembro não foi contabilizado), correspondendo aos meses do ano. Qualitativa ordinal.

# Variáveis qualitativas
table(arq$PRINCIPIO_ATIVO) # O único princípio ativo é o TOPIRAMATO
table(arq$SEXO) # O sexo feminino é o mais frequente
table(arq$UF_VENDA) # O estado de São Paulo é o mais frequente
table(arq$MES_VENDA) # O mês de setembro é o mais frequente

# Variáveis quantitativas
summary(arq$IDADE) # A média dos consumidores de TOPIRAMATO é de 42,81 anos
var(arq$IDADE) # A variância da variável IDADE é 205,3716
sd(arq$IDADE) # O desvio padrão da variável IDADE é 14,33079

install.packages("ggplot2")
library(ggplot2)
# Brazil (SP)

data <- subset(arq, IDADE >= 10 & IDADE < 100)
ggplot(data = data, aes(x = IDADE)) +
  geom_density(fill = "blue", alpha = 0.5) +
  labs(x = "IDADE") +
  ggtitle("Gráfico de Densidade do Conjunto de Dados Filtrado")

# Filtrar adolescentes (população de 13 a 17 anos)
adolescentes <- subset(arq, IDADE >= 13 & IDADE <= 17)
num_adolescentes <- nrow(adolescentes)
print(paste(num_adolescentes, "adolescentes"))
# Filtrar jovens (população de 18 a 39 anos)
jovens <- subset(arq, IDADE >= 18 & IDADE <= 39)
num_jovens <- nrow(jovens)
print(paste(num_jovens, "jovens"))
# Filtrar adultos (população de 40 a 59 anos)
adultos <- subset(arq, IDADE >= 40 & IDADE <= 59)
num_adultos <- nrow(adultos)
print(paste(num_adultos, "adultos"))
# Filtrar idosos (população de 60 anos ou mais)
idosos <- subset(arq, IDADE >= 60)
num_idosos <- nrow(idosos)
print(paste(num_idosos, "idosos"))

# Nova teoria: população de 40 a 59 anos (adultos) consome mais do que a população de 18 a 39 anos (jovens)
# Comparação de médias de idade de consumo do Topiramato de duas populações diferentes:
# População de 40 a 59 anos (adultos) = população A
# População de 18 a 39 anos (jovens) = população B

# Média dos adultos = 48,2533
mean(adultos$IDADE)
# Média dos jovens = 31,43845
mean(jovens$IDADE)

# Quantidade de adultos = 8705
num_adultos
# Quantidade de jovens = 7547
num_jovens

# Desvio padrão dos adultos = 5,594633
sd(adultos$IDADE)
# Desvio padrão dos jovens = 5,540495
sd(jovens$IDADE)

# Teste t de Student para duas amostras:
# Ho: μA = μB, hipótese nula, não há diferença significativa entre as médias de idade das duas populações
# Ha: μA ≠ μB, hipótese alternativa, há diferença significativa entre as médias de idade das duas populações
# Onde μA e μB representam a média de idade das populações A e B, respectivamente
# t = (xA - xB) / √((sA^2/nA) + (sB^2/nB))
# xA e xB são as médias das amostras A e B: 48,2533 e 31,43845, respectivamente
# sA e sB são os desvios padrão das amostras A e B: 5,594633 e 5,540495, respectivamente
# nA e nB são o tamanho das amostras A e B: 8705 e 7547, respectivamente

# t = (xA - xB) / √((sA^2/nA) + (sB^2/nB))
t = (48.2533 - 31.43845) / sqrt((5.594633^2/8705) + (5.540495^2/7547)); t
t.test(adultos$IDADE, jovens$IDADE)
# t = 192,084

# Graus de liberdade:
# gl = nA + nB - 2
# gl = 8705 + 7547 - 2
gl = 8705 + 7547 - 2; gl
# gl = 16250

# Nível de significância:
# a = 0,05

# Tabela de distribuição t de Student
# https://www.statisticshowto.com/tables/t-distribution-table/#two
# Two Tails T Distribution Table

# Valor crítico
#qt(1 - a, gl)
qt(1 - 0.05, 16250)
# xc = 1,644947

# t = 192,084

# Considerando que 192,084 é maior do que 1,644947, concluímos que t é maior que xc e, portanto, está dentro da região crítica RC.
# Como está dentro da região crítica, aceitamos a hipótese alternativa.
# Podemos concluir, então, que existem evidências estatísticas suficientes para afirmar que as médias de idades das duas populações são diferentes, ao nível de significância de 5%.
# Análise estatística com o objetivo de comparar o consumo do medicamento topiramato entre duas faixas etárias: adultoqs (40 a 59 anos) e jovens (18 a 39 anos). A hipótese era de que a população de adultos consumiria mais o medicamento em comparação com a população de jovens.

# A solução de rastreabilidade proposta é que a maior parte dos consumidores dessas duas populações é do sexo feminino.
table(adultos$SEXO)
table(jovens$SEXO)
barplot(table(adultos$SEXO), main = "Distribuição por Sexo para Adultos", xlab = "Sexo", ylab = "Frequência", names.arg = c("Masculino", "Feminino"))
barplot(table(jovens$SEXO), main = "Distribuição por Sexo para Jovens", xlab = "Sexo", ylab = "Frequência", names.arg = c("Masculino", "Feminino"))
