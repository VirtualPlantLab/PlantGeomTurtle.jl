using VPLTurtle
using Documenter

DocMeta.setdocmeta!(VPLTurtle, :DocTestSetup, :(using VPLTurtle); recursive=true)

makedocs(;
    modules=[VPLTurtle],
    authors="Alejandro Morales Sierra <alejandro.moralessierra@wur.nl> and contributors",
    repo="https://github.com/AleMorales/VPLTurtle.jl/blob/{commit}{path}#{line}",
    sitename="VPLTurtle.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
