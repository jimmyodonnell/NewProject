gghue <- function(n, alpha = 1){
# function for plot colors (sorta like ggplot)
	hues = seq(15, 375, length = n+1)
	hcl(h = hues, l = 65, c = 100, alpha = alpha)[1:n]
}
