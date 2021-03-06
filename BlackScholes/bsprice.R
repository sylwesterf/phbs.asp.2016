
#-------------------GBM option pricing --------------------
bsprice <- function(type, s, k, T, r, b, sigma){
    #------------------------------------------------
    #------------------------------------------------
    #Imput: type("call","put","straddle","digit")
    #       s is current price
    #       k is the strike price
    #       T is the time to maturity
    #       r is the risk-free rate
    #       b is the cost of carry (b eauals 0 for a future)
    #       sigma is the colatility
    #Return: the option price
    #        delta of the option
    #------------------------------------------------
    #------------------------------------------------

    d1 <- (log(s/k)+(b+0.5*sigma^2)*T)/(sigma*sqrt(T))
    d2 <- d1 - sigma*sqrt(T)
    if (type == "call" ){
        price <- exp((b-r)*T)*s*pnorm(d1)-k*exp(-r*T)*pnorm(d2)
        delta <- exp((b-r)*T)*pnorm(d1)
    }else{
        if (type == "put"){
            price <- k*exp(-r*T)*pnorm(-d2)-exp((b-r)*T)*s*pnorm(-d1)
            delta <- exp((b-r)*T)*pnorm(d1)-1
        }else{
            if (type == "straddle"){
                price <- exp((b-r)*T)*s*pnorm(d1)-k*exp(-r*T)*pnorm(d2)+k*exp(-r*T)*pnorm(-d2)-exp((b-r)*T)*s*pnorm(-d1)
                delta <- 2*exp((b-r)*T)*pnorm(d1)-1
            }else{
                if (type == "digit"){
                    price <- exp(-r*T)*pnorm(d2)*1
                    delta <- exp(-r*T)/sqrt(2*pi)*exp(-d2^2/2)/(s*sigma*sqrt(T))
                }
            }
        }
    }
    return(c(price=price,delta=delta))
}



