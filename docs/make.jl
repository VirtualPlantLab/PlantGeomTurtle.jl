using PlantTurtleGeom
using Documenter

DocMeta.setdocmeta!(PlantTurtleGeom, :DocTestSetup, :(using PlantTurtleGeom); recursive = true)

makedocs(;
    modules = [PlantTurtleGeom],
    authors = "Alejandro Morales Sierra <alejandro.moralessierra@wur.nl> and contributors",
    repo = "https://github.com/AleMorales/PlantTurtleGeom.jl/blob/{commit}{path}#{line}",
    sitename = "PlantTurtleGeom.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        edit_link = "master",
        assets = String[],
    ),
    pages = ["Home" => "index.md"],
)
