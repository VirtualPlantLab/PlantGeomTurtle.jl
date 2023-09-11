using Documenter, PlantGeomTurtle, DocumenterMarkdown

makedocs(;
         modules = [PlantGeomTurtle],
         format = Markdown(),
         authors = "Alejandro Morales Sierra <alejandro.moralessierra@wur.nl> and contributors",
         repo = "https://github.com/VirtualPlantLab/PlantGeomTurtle.jl/blob/{commit}{path}#{line}",
         sitename = "PlantGeomTurtle.jl",
         pages = [
             "Home" => "index.md",
         ])
