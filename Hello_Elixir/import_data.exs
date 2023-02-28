# Test data import file for practicing

# Usage:
# mix run import_data.exs <path_to_somewhere>

require Logger

Logger.configure(level: :info) # configures the logger

[code_translations | _] = System.argv() # save path to data. System.argv() lists command line arguments. By taking the head of the list, just the first element, i.e. the path is taken, not a list
mylist = System.argv()
islist = is_list(mylist)

Logger.info("Print:")

Logger.info("Given argument: #{code_translations}")

Logger.info("Without taking a head of the System.argv(), a list of all arguments would be saved: is_list(mylist) is #{islist}, returned value: #{mylist}")



Logger.info("End of the script.")
