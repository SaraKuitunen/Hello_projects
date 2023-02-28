# Elixir
# alias, require, and import

# In order to facilitate software reuse, Elixir provides three directives (alias, require and import) plus a macro called use

# Alias the MODULE so it can be called as Bar instead of Foo.Bar
alias Foo.Bar, as: Bar

# Require the MODULE in order to use its MACROS
require Foo

# Import FUNCTIONS or MACROS from Foo so they can be called without the `Foo.` prefix
import Foo

# Invokes the custom code defined in Foo as an EXTENSION POINT
use Foo

# Use is a common extension point that allows the used module to inject code.

# Alias, Require, and Import are directives because they have lexical scope,
# lexical scope allows usage inside function definitions
# e.g. invoking alias inside a function --> the alias will be valid only inside that function

###### alias

# Aliases are frequently used to define shortcuts.

alias Math.List
#Is the same as:
alias Math.List, as: List


###### require

# Elixir provides MACROS as a mechanism for meta-programming (writing code that generates code).
# Macros are expanded at compile time.

# Public functions in modules are globally available,
# but in order to use macros, the module they are defined in needs to be required.


###### import

# We use import whenever we want to access functions or macros
# from other modules without using the fully-qualified name.
# Note only public functions can be imported, as private functions are never accessible externally.

# import only the function duplicate (with arity 2) from List
import List, only: [duplicate: 2]

# Although :only is optional, its usage is recommended in order to
# avoid importing all the functions of a given module inside the current scope.

#:except could also be given as an option in order to import everything in a module except a list of functions.

# importing a module automatically requires it.


###### use

# The use macro is frequently used as an extension point.
# This means that, when you use a module FooBar, you allow that module to inject any code in the current
# module, such as importing itself or other modules, defining new functions, setting a module state, etc.

# Since use allows any code to run, knowing side-effects of using a module requires reading its documentation
# Therefore use this function with care and only if strictly required. Don’t use use where an import or alias would do.


###### Understanding Aliases

# An alias in Elixir is a capitalized identifier (like String, Keyword, etc) which is converted
# to an atom during compilation. For instance, the String alias translates by default to the atom :"Elixir.String"

# In the Erlang VM (and consequently Elixir) modules are always represented by atoms
# Using the alias/2 directive changes the atom the alias expands to.


###### Module nesting

defmodule Foo do
  defmodule Bar do
  end
end

# The second module can be accessed as Bar inside Foo as long as they are in the same lexical scope.

# If, later, the Bar module is moved outside the Foo module definition,
# it must be referenced by its full name (Foo.Bar) or an alias must be set.


###### Multi alias/import/require/use

# It is possible to alias, import or require multiple modules at once.
alias MyApp.{Foo, Bar, Baz}
