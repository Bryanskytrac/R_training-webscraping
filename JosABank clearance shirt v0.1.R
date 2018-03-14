#webscraping test v0.1


# Load the XML library
library(XML)

######Top Level

# setting the URL to pull from
import_url <- file.path("http://www.josbank.com/signature-wrinkle-free-spread-collar-tailored-fit-dress-shirt-clearance-5JD7C")


# this importing has the object imported as the html object class
import_html <- htmlParse(import_url)


# get the price attribute value directly
prices_list <- xpathSApply(import_html, "//input[@data-gtm='price']", xmlGetAttr, "value")


# checking for a text promotion
promo_text <- paste(xpathSApply(import_html, "//p[@data-gtm='promo']", xmlValue), collapse = "")

# gsub will replace any of these characters with a space within this string variable
promo_text <- gsub("[\r\n\t]", "", promo_text)


##############Checking for the correct size
right_size <- xpathSApply(import_html, "//div[@class='spot size-box ']//option[@value='16 1/2x34']", xmlGetAttr, "value")

# List all of the available colors
colors_list <- xpathSApply(import_html, "//div[@class='spot color-box ']//option", xmlGetAttr, "value")

# check for all sizes available 
# xpathSApply(import_html, "//div[@class='spot size-box ']//option", xmlGetAttr, "value")

prices_list
promo_text
right_size
colors_list



#################Everything Afterwards is unneccessary ########################

getNodeSet(import_html, "//ul[@class='size-chart-linklist']")


length(getNodeSet(import_html, "//ul[@class]"))
xpathSApply(import_html, "//ul[@class]", xmlValue)

xpathSApply(import_html, "//div[@class='spot size-box']", xmlGetAttr, "class")
getNodeSet(import_html, "//div[@class='product-options']//div")[5]

getNodeSet(import_html, "//div[@class='spot size-box ']//option")
xpathSApply(import_html, "//div[@class='spot size-box ']//option", xmlGetAttr, "value")

xpathSApply(import_html, "//p[@data-gtm='promo']", xmlValue)

xpathSApply(import_html, "//p", xmlGetAttr, "data-gtm")
getNodeSet(import_html, "//p[@data-gtm='promo']")

#paste(xpathSApply(import_html, "//p[@data-gtm='promo']", xmlValue), collapse = "")

# gsub will replace any of these characters with a space within this string variable
promo_text <- gsub("[\r\n\t]", "", promo_text)

xpathSApply(import_html, "//input[@data-gtm='price']", xmlValue)
getNodeSet(import_html, "//input[@data-gtm='price']")

xpathSApply(import_html, "//input[@data-gtm='price']", xmlGetAttr, "value")



# this importing has the object imported with the tree structure as part of the R object
import_html_tree <- htmlTreeParse(import_url)


xpathSApply(import_html, "//@ada-sizeAttrValueSelect_451207558", xmlValue)
xpathSApply(import_html, "//@productPrice_451207558", xmlValue)
paste(xpathSApply(import_html, "//@ada-sizeAttrValueSelect_451207558", xmlValue), collapse = "")
# xmlValue(getNodeSet(import_html_tree, "//@productPrice_451207558"))

summary(getNodeSet(import_html, "//@productPrice_451207558"))



# shirt size attribute value? = ada-sizeAttrValueSelect_451207558
# Price attribute? = productPrice_451207558

# offerprice
xpathSApply(import_html, "//span[@id='offerPrice']", xmlValue)

# try to get the price attribute value directly
xpathSApply(import_html, "//input[@data-gtm='price']", xmlValue)
getNodeSet(import_html, "//input[@data-gtm='price']")

xpathSApply(import_html, "//input[@data-gtm='price']", xmlGetAttr, "value")


# product price subset of nodes

xpathSApply(import_html, "//div[@class='product-price']", xmlValue)
length(xpathSApply(import_html, "//div[@class='product-price']", xmlValue))
# take each result at a time
xpathSApply(import_html, "//div[@class='product-price']", xmlValue)[1]
xpathSApply(import_html, "//div[@class='product-price']", xmlValue)[2]

# using xmlValue function to parse the whole <div> tag about product-price
paste(xpathSApply(import_html, "//div[@class='product-price']", xmlValue), collapse = "")

product_price_str <- paste(xpathSApply(import_html, "//div[@class='product-price']", xmlValue), collapse = "")

summary(product_price_str)

paste(xpathSApply(import_html, "//p[@data-gtm='promo']", xmlValue), collapse = "")

gsub("[\r\n\t]", " ", product_price_str) #replace any of these characters with a space within this string variable


# try using the node set to parse the data
price_nodes <- getNodeSet(import_html, "//div[@class='product-price']")
xmlSize(price_nodes)

price_tree_test <- htmlTreeParse(price_nodes)
xmlSize(price_tree_test)
price_tree_test$children$html$body

