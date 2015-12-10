library(shiny)
library(wordcloud)
library(ggplot2)

# prepare all the data ready
file_names <- dir('./Data/', "?.csv")
words_data <- data.frame()
#names(name_data) <- c("Name", "Sex", "Freq", "Year")
for (file in file_names) {
        temp_data <- read.csv(paste('./Data/', file, sep = ""), 
                              header = T, stringsAsFactors = F)
        temp_dept <- strsplit(file, '.csv')
        temp_data['dept'] <- temp_dept[[1]]
        words_data <- rbind(words_data, temp_data)
}

mapCoef2Freq <- function(list_coefs) {
        # mapping the coefficients to frequency 100 to 20
        # we know that input data will be sorted as descending order
        result <- as.integer(100 - 80 * (max(list_coefs) - list_coefs)/(max(list_coefs) - min(list_coefs)))
        return (result)
}

shinyServer(
        function(input, output) {
                
                # only do something if there is a input
                output$most_pos <- renderPlot({
                        temp_word_data <- words_data[words_data$dept==input$dept, ]
                        wordcloud(temp_word_data$pos_words, 
                                  mapCoef2Freq(temp_word_data$pos_coef), 
                                  colors=brewer.pal(8, "Dark2"))
                })
                
                output$most_neg <- renderPlot({
                        temp_word_data <- words_data[words_data$dept==input$dept, ]
                        wordcloud(temp_word_data$neg_words, 
                                  mapCoef2Freq(abs(temp_word_data$neg_coef)), 
                                  colors=brewer.pal(8, "Dark2"))
                })
                #output$dateRangeText <- renderPrint({descending})
        }
)