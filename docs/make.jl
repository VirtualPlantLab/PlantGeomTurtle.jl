using Documenter, PlantGeomTurtle

makedocs(;
    doctest = false,
    modules = [PlantGeomTurtle],
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        edit_link = "master",
        assets = String[],
    ),
    authors = "Alejandro Morales Sierra <alejandro.moralessierra@wur.nl> and contributors",
    repo = "https://github.com/VirtualPlantLab/PlantGeomTurtle.jl/blob/{commit}{path}#{line}",
    sitename = "PlantGeomTurtle.jl",
    pages = ["Home" => "index.md"],
)

deploydocs(;
    repo = "github.com/VirtualPlantLab/PlantGeomTurtle.jl.git",
    devbranch = "master",
)
