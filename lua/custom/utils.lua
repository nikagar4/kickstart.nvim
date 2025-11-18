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

function MergeArray(t1, t2)
  local local_table = {}
  for i = 1, #t1 do
    local_table[i] = t1[i]
  end
  for i = 1, #t2 do
    local_table[#t1 + 1] = t2[i]
  end
  return local_table
end

function Bind(fn, ...)
  local args = { ... }

  return function()
    return fn(unpack(args))
  end
end

function ColorColumnByFormatter(filename, column_length_key)
  local formatter_file_name = filename
  local file = io.open(formatter_file_name, 'r')

  if not file then
    return
  end

  local status, column = pcall(function()
    local content = file:read '*a'
    file:close()

    local data = vim.json.decode(content)
    local column = data[column_length_key]

    if not (type(column) == 'number') then
      error 'Corrupted column'
    end

    return column
  end)

  if not status then
    print 'error processing column length'
    print(column)
    return
  end

  vim.o.colorcolumn = string.format('%i', column)
end
