# test usage of environmental variables

# run this script, so that environmental variable is given. Otherwise, it's not found.
# env REPONAME="FG" elixir environmental_variables.exs
# env REPONAME="FR" elixir environmental_variables.exs
IO.puts("Testing environmental variables.")

IO.puts(System.get_env("PWD")) # test with already existing env variable
IO.puts(System.get_env("REPONAME")) # Test

reponame = System.get_env("REPONAME")
IO.puts(reponame) # Test

# alias Repo.{reponame}
# --> (CompileError) environmental_variables.exs:10: invalid argument for alias, expected a compile time atom or alias, got: reponame

# alias Repo.{System.get_env("REPONAME")}
# ** (CompileError) environmental_variables.exs:16: invalid argument for alias, expected a compile time atom or alias, got: System.get_env("REPONAME")

# alias Repo.reponame
# ** (CompileError) environmental_variables.exs:19: invalid argument for alias, expected a compile time atom or alias, got: Repo.reponame
# (elixir 1.12.2) lib/code.ex:1261: Code.require_file/2

# OPTION: have same alias for both repos and comment out the one that is not needed.
# BUT this is risky solution, because if commenting out is forgotten, this leads to unwanted behaviour
#alias Risteys.Repo_FR, as: Repo
#alias Risteys.Repo_FG, as: Repo
#IO.puts(Repo) # Elixir.Risteys.Repo_FG

# do contitional using environmental variable and

#case reponame do
#  reponame when reponame === "FG" ->
#    alias Risteys.Repo_FG, as: Repo
#    IO.puts("repo is: #{Repo}")
#    # call function to import data
#  reponame when reponame === "FR" ->
#    alias Risteys.Repo_FR, as: Repo
#    IO.puts("repo is: #{Repo}")
#    # call function to import da
#  _ -> IO.puts("Environmental variable for project specification is not given or it's incorrect (needs to be 'FG' or 'FR")
#end

# NOTE, outside the case, the alias is not saved.
#IO.puts("repo is: #{Repo}")

#if reponame === "FR" do
#  alias Risteys.Repo_FR, as: Repo
#  IO.puts("repo is: #{Repo}")
#end
#IO.puts("repo is: #{Repo}")

repo =
  case System.get_env("REPONAME") do
    "FG" -> Risteys.Repo_FG
    "FR" -> Risteys.Repo_FR
    _ -> "Environmental variable specifying project is missing"
  end

IO.puts("repo: #{repo}") # Elixir.Risteys.Repo_FR
