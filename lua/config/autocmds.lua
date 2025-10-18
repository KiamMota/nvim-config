local corrections = {
  ["include"] = {"INcluide", "incldue", "inclide", "Include", "incblduye", "incluyde"},
  ["length"] = {"lenght", "lengh"},
  ["namespace"] = {"namesapce", "namespce"},
  ["return"] = {"retun", "retrn"},
  ["width"] = {"witdht", "widht"},
  ["function"] = {"fucntion", "functoin"},
  ["const"] = {"constr", "cosnt"},
  ["class"] = {"calss", "lcass", "clas"},
  ["void"] = {"voud", "vodi"},
  ["define"] = {"DEFINE", "deifnde", "deinfe", "dei0fne"},
  ["while"] = {"wilhe", "wihle", "whie"},
  ["switch"] = {"siwtch", "swithc", "esicjh", "sich", "swtich,", "stich"},
  ["virtual"] = {"virutal", "virutla", "virtula", "viutal"} 
}

for correct, wrongs in pairs(corrections) do
  for _, wrong in ipairs(wrongs) do
    vim.cmd(string.format("iabbrev %s %s", wrong, correct))
  end
end

