
#����Apple��Google��΢�����ҹ�Ʊ���ݣ��������Ǵ�2008�굽2011��ÿ����ܳɽ�����
#Ȼ��һ�ѵ���ʽ��ֱ��ͼ���������ϱ�ע��Ʊ����ֱ��ͼ����ÿһ��ɽ���ռ�ܳɽ����İٷֱ�
#����ٷֱ�Ҫ��ע��ֱ��ͼ�ڲ�����ɫ������ͬ����ݣ���ͼ��˵���� 

library(quantmod)
library(tseries)

aapl<- get.hist.quote(instrument = "aapl", quote =  "Vol", start="2008-01-01", end="2011-12-31")
goog <- get.hist.quote(instrument = "goog", quote = "Vol", start="2008-01-01", end="2011-12-31")
msft <- get.hist.quote(instrument = "msft", quote = "Vol", start="2008-01-01", end="2011-12-31")

ap <- as.numeric( Vo( to.yearly(aapl)))
go <- as.numeric( Vo( to.yearly(goog)))
ms <- as.numeric( Vo( to.yearly(msft)))

stock <- data.frame(yr=c("2008" , "2009" , "2010", "2011") ,  
                    apple = ap/sum(ap), 
                    google = go/sum(go), 
                    microsoft = ms/sum(ms))


x <- barplot( as.matrix( stock[,-1]) , beside= T, col = rainbow(4), ylim=c(0,0.5) )
y <- c(  ap/sum(ap), go/sum(go),  ms/sum(ms) )/2
text( x, y , paste( round(y *100), "%", sep="" ), cex = 0.6 )
legend( "topright", legend=stock$yr, horiz=T, bty="n" , cex = 0.8, pch=5, col= rainbow(4) )