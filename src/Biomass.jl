module Biomass
#greet() = print("Hello World!")
    #Developed by:
    #PhD. Arick Castillo Landero
    #PhD. Jorge Arturo Aburto Abell
    #PhD. ELías Martínez Hernández

    #Function to call the GUI
    export mainBio
    export BiomassGUI

    #Include the main file  .fl
    #include("BiomassGUI.jl")
    include("index.jl")
    include("main.jl")
end #module
