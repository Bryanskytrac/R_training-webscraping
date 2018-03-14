#webscraping test v0.6

####Library loading####
# Load the XML library
library(XML)
# library(xml2)
# Load other libraries
library(methods)
library(utils)
library(dplyr)

# Set the working directory
working_dir <- "C:/Temp/R_Training-Webscraping"
setwd(working_dir)

####Sitemap URL and parse####
# Get the list of URLs from the sitemap 
sitemap_url <- "http://josbank.com/sitemap.xml"

# Use the htmlParse function to parse the sitemap xml file. 
# Because the XML schema namespaces are not loading correctly, 
# I am using treating the sitemap.xml file as html so that I can parse it.
sitemap_html <- htmlParse(sitemap_url)


# the xml file is now saved as an object & this function shows the object class properties
class(sitemap_html)


############# Time delay function ###########
# Sys.sleep(10) # Time delay in seconds for querying website between URLs


# This counts how many files(html web pages) will be accessed and allows me to create the correct size of output dataframe
#OLD total_num_import_files <- length(sitemap_xml)
total_num_urls <- length(getNodeSet(sitemap_html, "//url/loc"))

df_URLs <- data.frame(xpathSApply(sitemap_html, "//url/loc", xmlValue), stringsAsFactors = FALSE)

names(df_URLs) <- c("URL_Column")

#### For the initial testing of this script, I took a random sample of rows (URLs) 
# df_URLs <- dplyr::sample_n(df_URLs,200)


# Filter down to the needed rows
# Contains "dress-shirt" 
df_URLs_f <- dplyr::filter(df_URLs,grepl("dress-shirt",df_URLs$URL_Column))
# Does not contain "big-tall" Not "button-down-collar" Not "cutaway-collar" Not "short-sleeve" Not "big-and-tall" Not "shirts" 
df_URLs_f <- dplyr::filter(df_URLs_f,!grepl("big-tall",df_URLs_f$URL_Column))
df_URLs_f <- dplyr::filter(df_URLs_f,!grepl("button-down-collar",df_URLs_f$URL_Column))
df_URLs_f <- dplyr::filter(df_URLs_f,!grepl("cutaway-collar",df_URLs_f$URL_Column))
df_URLs_f <- dplyr::filter(df_URLs_f,!grepl("short-sleeve",df_URLs_f$URL_Column))
df_URLs_f <- dplyr::filter(df_URLs_f,!grepl("big-and-tall",df_URLs_f$URL_Column))
df_URLs_f <- dplyr::filter(df_URLs_f,!grepl("shirts",df_URLs_f$URL_Column))

# Should I filter on contains "clearance"?
df_URLs_f <- dplyr::filter(df_URLs_f,grepl("clearance",df_URLs_f$URL_Column))


total_num_import_files <- length(df_URLs_f[,1])

 
# # Create vector of imported xpath tag names from imported file list
# import_tag_names_filepath <- file.path(working_dir, "import_tag_names_ETF.txt")
# import_tag_names <- readLines(import_tag_names_filepath, n = -1L, ok = TRUE, warn = TRUE, encoding = "UTF-8", skipNul = TRUE)
# 
# # Create vector of of xpath tag names from imported file list
# import_tag_length <- length(import_tag_names) # file length with first blank row
# import_tag_names <- import_tag_names[2:import_tag_length] # truncate/remove the first blank row for xpath tag names from the imported file
# num_tags <- length(import_tag_names) # number of xpath tag names after the first blank row was removed
 
# Create vector of column names 
# import_col_names_filepath <- file.path(working_dir, "import_column_names_ETF.txt")
# import_col_names <- readLines(import_col_names_filepath, n = -1L, ok = TRUE, warn = TRUE, encoding = "UTF-8", skipNul = TRUE)

export_col_names <- c("URL", "prices_list", "promo_text", "right_size", "colors_list")
 
# # remove first "empty" row from list of columns
# import_col_length <- length(import_col_names) # file length with first blank row
# import_col_names <- import_col_names[2:import_col_length] # truncate/remove the first blank row for column names from the imported file

num_columns <- length(export_col_names)

## Initialize export dataframe
# Number of rows = total_num_import_files # Number of columns = num_columns
# df <- data.frame(matrix(vector(), total_num_import_files, num_columns, dimnames=list(c(), c(import_col_names))), stringsAsFactors=FALSE)
df <- data.frame(matrix(vector(), total_num_import_files, num_columns, dimnames=list(c(), export_col_names)), stringsAsFactors=FALSE)

# # df2 is for recording the number of tags found for each tag search
# df2 <- data.frame(matrix(vector(), total_num_import_files, num_columns, dimnames=list(c(), c(import_col_names))))
df2 <- data.frame(matrix(vector(), total_num_import_files, num_columns, dimnames=list(c(), export_col_names)))
# 

# This will tell me which file to import in the list, when it equals 1 then it will be the first one
my_counter <- 1

# ## BEGIN LOOP THROUGH FILENAME LIST - Each loop will import a single row from a single file

for (k in 1:total_num_import_files)
{

  # # Take a 30 second break every 10 URLs ????
  if((k%/%10) == 0){
    "start break"
    Sys.sleep(10) # Time delay in seconds for querying website between URLs, if needed
    "done break"
  }

  
  my_counter <- k

  #   filename_current <- import_filenames[my_counter] 
  # setting the URL to pull from
  url_current <- df_URLs_f[my_counter,1]
  
  # this importing has the object imported as the html object class
  import_html <- htmlParse(url_current)
  
  # Store static values for current row/filename
#   df[k,1] <- filename_current # add Filename to first column of dataframe
#   df[k,num_columns] <- "N" # Set default stating that no fields were truncated
#   df2[k,1] <- filename_current
#   df2[k,num_columns] <- "N"

  df[k,"URL"] <- url_current # add URL to first column of export dataframe
  df2[k,"URL"] <- url_current # add URL to first column of double-check dataframe
  
  # Checking for the correct size
  num_correct_size_nodes <- length(getNodeSet(import_html, "//div[@class='spot size-box ']//option[@value='16 1/2x34']"))
  
  if (num_correct_size_nodes == 1){  
    df[k,"right_size"] <- paste(xpathSApply(import_html, "//div[@class='spot size-box ']//option[@value='16 1/2x34']", xmlGetAttr, "value"), collapse = " ")
  } 

  # get the price attribute value directly
  # OLD df[k,"prices_list"] <- paste(xpathSApply(import_html, "//div/span[@data-gtm='price']", xmlValue), collapse = "")
  # OLD df[k,"prices_list"] <- gsub("[\r\n\t]", " ", df[k,"prices_list"])
  # OLD xpathSApply(import_html, "//div[@class='product-price']//span[@data-gtm='price']", xmlGetAttr, "value")
  # OLD xpathSApply(import_html, "//div[@class='product-price']//span[@data-gtm='price']", xmlValue)
  
  # test for multiple prices
  num_price_nodes <- length(getNodeSet(import_html, "//div[@itemtype='http://schema.org/Offer']/meta[@itemprop='price']"))
  if(num_price_nodes == 1){
    df[k,"prices_list"] <- xpathSApply(import_html, "//div[@itemtype='http://schema.org/Offer']/meta[@itemprop='price']", xmlGetAttr, "content")
  } else if (num_price_nodes > 1){
    df[k,"prices_list"] <- paste0("Multiple ",paste(xpathSApply(import_html, "//div[@itemtype='http://schema.org/Offer']/meta[@itemprop='price']", xmlGetAttr, "content"), collapse = ", "))
  }
  # checking for a text promotion
  df[k,"promo_text"] <- paste(xpathSApply(import_html, "//p[@data-gtm='promo']", xmlValue)[1], collapse = "")
  # gsub will replace any of these characters with a space within this string variable
  df[k,"promo_text"] <- gsub("[\r\n\t]", "", df[k,"promo_text"])
  
  df2[k,"promo_text"] <- paste(xpathSApply(import_html, "//p[@data-gtm='promo']", xmlValue), collapse = " ")
  # gsub will replace any of these characters with a space within this string variable
  df2[k,"promo_text"] <- gsub("[\r\n\t]", "", df[k,"promo_text"])
  
  # List all of the available colors  
  # df[k,"colors_list"] <- paste(xpathSApply(import_html, "//div[@class='spot color-box ']//option", xmlGetAttr, "value"), collapse = ",")
  df[k,"colors_list"] <- paste(xpathSApply(import_html, "//img[@class='product-color']", xmlGetAttr, "title"), collapse = ", ")
  df2[k,"colors_list"] <- paste(xpathSApply(import_html, "//img[@class='product-color']", xmlGetAttr, "title"), collapse = ", ")      
  
  # List all of the sizes available in df2
  df2[k,"right_size"] <- paste(xpathSApply(import_html, "//div[@class='spot size-box ']//option", xmlGetAttr, "value"), collapse = ",")    
  # List all of the prices in df2
  df2[k,"prices_list"] <- paste(xpathSApply(import_html, "//div[@itemtype='http://schema.org/Offer']/meta[@itemprop='price']", xmlGetAttr, "content"), collapse = " ")

  
    
    
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


} # END OF (ROW) LOOP



############################### COPY-PASTE from XML parsing to export dataframe to CSV file

### Write dataframe to csv function
filename_new <- "export_complete.csv"
write_path <- file.path(working_dir, filename_new)
write.csv(df, file = write_path, row.names = FALSE)

# export partial temp file writing command
# write.csv(df, file = file.path(working_dir, "export_partial.csv"), row.names = FALSE)

filename_error_checking <- "export_error_checking.csv"
write_path_error_checking <- file.path(working_dir, filename_error_checking)
write.csv(df2, file = write_path_error_checking, row.names = FALSE)

