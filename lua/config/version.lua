local M = {}

local function parse_version(version)
  local major, minor, patch = version:match("^(%d+)%.(%d+)%.(%d+)$")
  assert(major, "Invalid version string: " .. version)

  return {
    major = tonumber(major),
    minor = tonumber(minor),
    patch = tonumber(patch),
  }
end

local function is_at_least(current, required)
  if current.major ~= required.major then
    return current.major > required.major
  end
  if current.minor ~= required.minor then
    return current.minor > required.minor
  end
  return current.patch >= required.patch
end

function M.require_nvim(min_version)
  local required = parse_version(min_version)
  local current = vim.version()

  if not is_at_least(current, required) then
    vim.schedule(function()
      vim.notify(
        string.format(
          "This config is designed for neovim >= %s (found %d.%d.%d)",
          min_version,
          current.major,
          current.minor,
          current.patch
        ),
        vim.log.levels.ERROR
      )
    end)
    return false
  end

  return true
end

return M
