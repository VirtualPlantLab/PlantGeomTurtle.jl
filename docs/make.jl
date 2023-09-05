using PlantGeomTurtle
using Documenter

DocMeta.setdocmeta!(PlantGeomTurtle, :DocTestSetup, :(using PlantGeomTurtle); recursive = true)

makedocs(;
    modules = [PlantGeomTurtle],
    authors = "Alejandro Morales Sierra <alejandro.moralessierra@wur.nl> and contributors",
    repo = "https://github.com/AleMorales/PlantGeomTurtle.jl/blob/{commit}{path}#{line}",
    sitename = "PlantGeomTurtle.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        edit_link = "master",
        assets = String[],
    ),
    pages = ["Home" => "index.md"],
)
