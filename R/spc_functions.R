#' Get data ready for SPC plotting
#'
#' @param data dataframe containing "date" column and an FFT column
#' @param variable string, indicating the name of the FFT column
#' @param chunks either "monthly", which divides the data in months 
#' or the number of chunks to divide the data into (each chunk will have the 
#' same number of rows)
#' @param return dataframe suitable for plotting with qicharts2
#'
#' @return
#' @export
split_data_spc <- function(data, variable = "fft", chunks){
  
  if(chunks == "monthly"){
    
    return(
      data %>% 
        dplyr::mutate(date = as.Date(cut(date, "month"))) %>% 
        dplyr::mutate(fft = .data[[variable]] * 20)
    )
  } else {
    
    return(
      data %>% 
        dplyr::filter(.data[[variable]] %in% 1 : 5) %>% 
        dplyr::mutate(group = ceiling(dplyr::cur_group_rows() / nrow(.) * chunks)) %>% 
        dplyr::group_by(group) %>% 
        dplyr::mutate(date = min(date)) %>% 
        dplyr::mutate(fft = .data[[variable]] * 20)
    )
  }
}

#' Plot data
#'
#' @param data dataframe, that you probably made with the split_data_spc function
#' @param return SPC plot
#'
#' @return
#' @export
plot_fft_spc <- function(data){
  
  data %>% 
    qicharts2::qic(data = .,
                   x = date,
                   y = fft,
                   chart = "xbar",
                   xlab = "Date",
                   ylab = "% FFT score")
}
