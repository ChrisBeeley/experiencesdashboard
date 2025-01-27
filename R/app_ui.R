#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
    
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    dashboardPage(
      
      dashboardHeader(title = "Patient experience",
                      titleWidth = 300),
      dashboardSidebar(
        width = 300,
        sidebarMenu(
          
          menuItem("Patient experience", 
                   tabName = "experiences-user",
                   icon = shiny::icon("comment"),
                   selected = TRUE,
                   badgeLabel = "dev", badgeColor = "green"),
          
          uiOutput("filter_location_1"),
          uiOutput("filter_location_2"),
          uiOutput("filter_location_3"),
          dateRangeInput(
            "date_range",
            label = h5(strong("Select date range:")),
            start = as.Date("2019-01-01"),
            end = Sys.Date()
          )
        )
      ),
      dashboardBody(
        ### Changing theme
        dashboardthemes::shinyDashboardThemes(
          theme = "grey_light"
        ),
        HTML('<a href="https://github.com/CDU-data-science-team/experiencesdashboard" 
             class="github-corner" aria-label="View source on GitHub"><svg width="80" 
             height="80" viewBox="0 0 250 250" style="fill:#64CEAA; color:#fff; position: 
             absolute; top: 50; border: 0; right: 0;" aria-hidden="true"><path d="M0,0 
             L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 
             C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 
             C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 
             C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" 
             style="transform-origin: 130px 106px;" class="octo-arm"></path><path 
             d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 
             C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 
             C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 
             C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 
             C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 
             C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 
             C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 
             L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" 
             class="octo-body"></path></svg></a><style>.github-corner:hover 
             .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes 
             octocat-wave{0%,100%{transform:rotate(0)}20%,
             60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media 
             (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner 
             .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style>'),
        tabItems(
          tabItem(tabName = "experiences-user",
                  # h1("Service User Experiences"),
                  mod_patient_experience_ui("patient_experience_ui_1")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'experiencesdashboard'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

