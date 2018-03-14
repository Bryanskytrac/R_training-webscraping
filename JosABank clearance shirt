#webscraping test v0.2


# Load the XML library
library(XML)
library(xml2)
# Load other libraries
library(methods)
library(utils)

# Set the working directory
setwd("C:/Temp/R_Training-Webscraping")

###### Get the list of URLs from the sitemap
sitemap_url <- "http://josbank.com/sitemap.xml"


# Use the xmlParse-function to parse the xml file # Validate = TRUE means that the XML file will be compared to the DTD file (if available)
# sitemap_xml <- xmlParse(sitemap_url)
# sitemap_xml4 <- xmlParseDoc(sitemap_url, asText = FALSE)
# sitemap_xml2 <- read_xml(sitemap_url, options = c("NOBLANKS","NSCLEAN"))

# Use the htmlParse function to parse the sitemap xml file. 
# Because the XML schema namespaces are not loading correctly, 
# I am using treating the sitemap.xml file as html so that I can parse it.
sitemap_html <- htmlParse(sitemap_url)


# the xml file is now saved as an object & this function shows the object class properties
class(sitemap_html)


#############
# Sys.sleep(10) # Time delay in seconds for querying website between URLs
#############



# # This counts how many files will be modified and allows me to create the correct size of dataframe
# total_num_import_files <- length(sitemap_xml)

class(sitemap_xml)
str(sitemap_xml)
xmlNamespace(xmlRoot(sitemap_xml))[1]
getNodeSet(sitemap_xml, "//urlset/url/loc", namespaces = xmlNamespaceDefinitions(sitemap_xml, simplify = TRUE))
lengetNodeSet(sitemap_xml, "//urlset/url/loc")

class(sitemap_html)
class(sitemap_html_tree)
str(sitemap_html)
length(getNodeSet(sitemap_html, "//urlset/url/loc"))

xmlNamespaceDefinitions(xmlRoot(sitemap_xml))
getNodeSet(sitemap_xml, "//urlset//url//loc", namespaces = xmlNamespace(xmlRoot(sitemap_xml))[1])


length(getNodeSet(sitemap_xml4, "//urlset//url//loc"))
xmlNamespaceDefinitions(sitemap_xml, simplify = TRUE)
xmlNamespaces(sitemap_xml, simplify = TRUE)
xmlNamespaces(sitemap_xml)

xml_find_all(sitemap_xml2,"//url//loc", ns = xml_ns(sitemap_xml2))

length(sitemap_xml2)

xpathSApply(sitemap_xml, "//loc", xmlValue)
xpathApply(sitemap_xml, "/url/loc", xmlValue)

length(xpathSApply(sitemap_xml, "/url/loc", xmlValue))
sitemap_xml

length(xpathSApply(xml_current, import_tag_names[m], xmlValue))
total_num_urls <- length(xpathSApply(xml_current, import_tag_names[m], xmlValue))

# #### For the initial testing of this script, I reset this value to be 3
total_num_urls <- 3

# # This will tell me which file to import in the list, when it equals 1 then it will be the first one
# my_counter <- 1
# 
# # Create vector of imported xpath tag names from imported file list
# import_tag_names_filepath <- file.path(working_dir, "import_tag_names_ETF.txt")
# import_tag_names <- readLines(import_tag_names_filepath, n = -1L, ok = TRUE, warn = TRUE, encoding = "UTF-8", skipNul = TRUE)
# 
# # Create vector of of xpath tag names from imported file list
# import_tag_length <- length(import_tag_names) # file length with first blank row
# import_tag_names <- import_tag_names[2:import_tag_length] # truncate/remove the first blank row for xpath tag names from the imported file
# num_tags <- length(import_tag_names) # number of xpath tag names after the first blank row was removed
# 
# # Create vector of column names from imported file list
# import_col_names_filepath <- file.path(working_dir, "import_column_names_ETF.txt")
# import_col_names <- readLines(import_col_names_filepath, n = -1L, ok = TRUE, warn = TRUE, encoding = "UTF-8", skipNul = TRUE)
# 
# # remove first "empty" row from list of columns
# import_col_length <- length(import_col_names) # file length with first blank row
# import_col_names <- import_col_names[2:import_col_length] # truncate/remove the first blank row for column names from the imported file
# num_columns <- length(import_col_names) # number of columns after the first blank row was removed
# 
# (num_columns - num_tags == 7) # Test to see if the imports worked correctly ( 5 business fields + 1 column for the filename + 1 column for the Y/N "DuplicatesTruncated")
# 
# ## Initialize dataframe 
# # Number of rows = total_num_import_files # Number of columns = num_columns
# df <- data.frame(matrix(vector(), total_num_import_files, num_columns, dimnames=list(c(), c(import_col_names))), stringsAsFactors=FALSE)
# # df2 is for recording the number of tags found for each tag search
# df2 <- data.frame(matrix(vector(), total_num_import_files, num_columns, dimnames=list(c(), c(import_col_names))))
# 
# ## BEGIN LOOP THROUGH FILENAME LIST - Each loop will import a single row from a single file
# 
# for (k in 1:total_num_import_files)
# {
#   my_counter <- k
#   
#   filename_current <- import_filenames[my_counter] 
#   read_path <- file.path(working_dir, filename_current)
#   
#   
#   # Use the xmlParse-function to parse the xml file # Validate = TRUE means that the XML file will be compared to the DTD file (in the same directory?)
#   xml_current <- xmlParse(read_path, validate = TRUE)
#   # the xml file is now saved as an object & this function shows the object class properties
#   class(xml_current)
#   
#   # Store static values for current row/filename
#   df[k,1] <- filename_current # add Filename to first column of dataframe
#   df[k,num_columns] <- "N" # Set default stating that no fields were truncated
#   df2[k,1] <- filename_current
#   df2[k,num_columns] <- "N"
#   
#   ## BEGIN XPATH NESTED LOOP - Go through each of the tags (columns) in the current XML file
#   for (m in 1:num_tags)
#   {
#     
#     ############# SANDBOX - Do we need a space between values & should we only take the first value?
#     
#     num_nodes <- length(xpathSApply(xml_current, import_tag_names[m], xmlValue))
#     df2[k,m+1] <- num_nodes
#     
#     if (num_nodes == 1){
#       # Save value straight into the dataframe 
#       df[k,m+1] <- paste(xpathSApply(xml_current, import_tag_names[m], xmlValue), collapse = "");
#       
#     } else { if (num_nodes > 1) {
#       df[k,m+1] <- paste(xpathSApply(xml_current, import_tag_names[m], xmlValue)[1], collapse = "");
#       df[k,num_columns] <- "Y" # Record YES that a field was truncated
#       
#       df2[k,num_columns] <- "Y" # Record YES that a field was truncated
#       
#     }
#     }
#     
#     
#     ###############
#     
#     
#   } # END OF XPATH NESTED LOOP
#   
#   
# } # END OF (ROW) LOOP



###### This is a single URL pass

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

################################ COPY-PASTE from XML parsing to export dataframe to CSV file
# 
# ### Write dataframe to csv function 
# filename_new <- "export_complete.csv"
# write_path <- file.path(working_dir, filename_new)
# write.csv(df, file = write_path, row.names = FALSE)
# 
# filename_counts <- "export_tag_count.csv"
# write_path_counts <- file.path(working_dir, filename_counts)
# write.csv(df2, file = write_path_counts, row.names = FALSE)
# 


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

