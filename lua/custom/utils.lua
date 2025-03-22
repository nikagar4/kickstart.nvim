local WINDOWS = 'windows'
local LINUX = 'linux'
local MAC = 'macos'

function os.name()
  local binaryFormat = package.cpath:match '%p[\\|/]?%p(%a+)'
  if binaryFormat == 'dll' then
    return WINDOWS
  elseif binaryFormat == 'so' then
    return LINUX
  elseif binaryFormat == 'dylib' then
    return MAC
  end
end

os.is = {
  windows = os.name() == WINDOWS,
  linux = os.name() == LINUX,
  macos = os.name() == MAC,
}

function Merge(first_table, second_table)
  for k, v in pairs(second_table) do
    first_table[k] = v
  end
end
