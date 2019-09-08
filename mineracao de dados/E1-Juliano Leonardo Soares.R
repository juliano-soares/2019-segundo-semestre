getwd()
file.exists("vendas_lucro.csv")
DF_vendasLucro <- read.table("vendas_lucro.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# Construindo a função para Transformacao Linear Min-Max
rnorm<-function(planilha, minimo=0, maximo=1) {
  for(i in 1:ncol(planilha)){
    if(is.numeric(planilha[,i])){
      v_min<-min(planilha[,i])
      v_max<-max(planilha[,i])
      for(j in 1:nrow(planilha)){
        planilha[j,i]<-((planilha[j,i]-v_min)/(v_max-v_min))*((maximo-minimo)+minimo)
      }
    }
  }
  return(planilha) # Retornando a planilha normalizada
}


# Construindo a função para normalizacao por Abrangencia interquartil 
Inorm<-function(planilha) {
  for(i in 1:ncol(planilha)){
    if(is.numeric(planilha[,i])){
      x <- planilha[,i]
	Q1 <- quantile(x,c(0.25))
	Q2 <- quantile(x,c(0.5))
	Q3 <- quantile(x,c(0.75))
      for(j in 1:nrow(planilha)){
        planilha[j,i]<- (planilha[j,i] - Q2)/(Q3 - Q1)
      }
    }
  }
  return(planilha) # Retornando a planilha normalizada
}


# Construindo a função para normalizacao por Z-Score
Znorm<-function(planilha) {
  for(i in 1:ncol(planilha)){
    if(is.numeric(planilha[,i])){
	media <- mean(planilha[,i])
      stdx  <- sd(planilha[,i])
      for(j in 1:nrow(planilha)){
        planilha[j,i]<- (planilha[j,i] - media) /stdx
      }
    }
  }
  return(planilha) # Retornando a planilha normalizada
}

# Construindo a função para normalizacao por escala decimal
Dnorm<-function(planilha) {
  for(i in 1:ncol(planilha)){
    if(is.numeric(planilha[,i])){
	j <- 0
	v_max <- max(abs(planilha[,i]))
	while((v_max / (10^j)) > 1){
		j <- j+1
	} 
      for(k in 1:nrow(planilha)){
        planilha[k,i]<- planilha[k,i] /(10^j)
      }
    }
  }
  return(planilha) # Retornando a planilha normalizada
}

DF_MinMax <- rnorm(DF_vendasLucro)
DF_zScore <- Znorm(DF_vendasLucro)
DF_Decimal <- Dnorm(DF_vendasLucro)
DF_Interquartil <- Inorm(DF_vendasLucro)

DF_Completa <- data.frame("Original" = DF_vendasLucro,"Max-Min" = DF_MinMax,"Z-Score" = DF_zScore,"Esc. Decimal"= DF_Decimal,"Interquartil"=DF_Interquartil)
DF_Completa 



