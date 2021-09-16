using Documenter
import Pkg
using SmartShockFinder

# Define module-wide setups such that the respective modules are available in doctests
DocMeta.setdocmeta!(SmartShockFinder, :DocTestSetup, :(using SmartShockFinder); recursive=true)

# Make documentation
makedocs(
    # Specify modules for which docstrings should be shown
    modules = [SmartShockFinder],
    # Set sitename to SmartShockFinder
    sitename="SmartShockFinder.jl",
    # Provide additional formatting options
    format = Documenter.HTML(
        # Disable pretty URLs during manual testing
        prettyurls = get(ENV, "CI", nothing) == "true",
        # Explicitly add favicon as asset
        # assets = ["assets/favicon.ico"],
        # Set canonical URL to GitHub pages URL
        canonical = "https://trixi-framework.github.io/SmartShockFinder.jl/dev"
    ),
    # Explicitly specify documentation structure
    pages = [
        "Home" => "index.md",
        "Reference" => "reference.md",
        "License" => "license.md"
    ],
    strict = true # to make the GitHub action fail when doctests fail, see https://github.com/neuropsychology/Psycho.jl/issues/34
)

deploydocs(
    repo = "github.com/trixi-framework/SmartShockFinder.jl",
    devbranch = "main",
    push_preview = true
)
