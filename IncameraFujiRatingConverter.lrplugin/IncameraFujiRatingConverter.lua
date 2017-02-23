local LrTasks = import 'LrTasks'
local LrFileUtils = import 'LrFileUtils'
local LrApplication = import 'LrApplication'

local logger = import 'LrLogger'('IncameraFujiRatingConverter')
logger:enable('print')
logger:info(' -------------------- Execution start --------------------')

-- TODO: create a settings panel in plugin manager to set this value
local exiftoolPath
if (MAC_ENV) then
  exiftoolPath = '/usr/local/bin/exiftool'
else
  exiftoolPath = 'C:\\\Windows\\\exiftool.exe'
end

function main()
  local catalog = LrApplication.activeCatalog()
  local targetPhotos = catalog.targetPhotos
  for i, photo in ipairs(targetPhotos) do
    -- TODO: show some kind of progress bar and/or notification once the ratings are converted
    LrTasks.startAsyncTask(function()
      local filePath = photo.path
      local fileWithoutExtension = GetFilePathWithoutExtension(filePath);
      setRatingForJpgAndRaf(fileWithoutExtension)
    end)
  end
end

function GetFilePathWithoutExtension(url)
  return url:match("^([^.]+)")
end

function setRatingForJpgAndRaf(fileWithoutExtension)
  local jpgFile = GetJpgFile(fileWithoutExtension)

  if jpgFile then
    local rating = GetRatingFromFile(jpgFile)
    if rating then
      local rafFile = GetRafFile(fileWithoutExtension)
      setRating(jpgFile, rating)

      if rafFile then
        local xmpFile = fileWithoutExtension .. '.xmp'
        setRating(xmpFile, rating)
      end
    end
  end
end

function GetJpgFile(fileWithoutExtension)
  -- TODO: make this work by ignoring letter case
  local supportedJpgFileExtensions = {'.JPG', '.jpg'}
  return GetFile(fileWithoutExtension, supportedJpgFileExtensions)
end

function GetRafFile(fileWithoutExtension)
  -- TODO: make this work by ignoring letter case
  local supportedRafFileExtensions = {'.RAF', '.raf'}
  return GetFile(fileWithoutExtension, supportedRafFileExtensions)
end

function GetFile(fileWithoutExtension, extensions)
  for i, extension in ipairs(extensions) do
    local fileWithExtension = fileWithoutExtension .. extension
		if LrFileUtils.exists(fileWithExtension) and LrFileUtils.isReadable(fileWithExtension) then
      logger:info(' Found file: ', fileWithExtension)
      return fileWithExtension
    end
  end
end

function setRating(file, rating)
  logger:info(' Setting rating for file: ', file, ' rating: ', rating)
  LrTasks.execute(exiftoolPath .. ' -overwrite_original -rating=' .. rating .. ' "' .. file .. '"')
end

function GetRatingFromFile(file)
  local tmpFileForRatingOutput = os.tmpname()
  local result = LrTasks.execute(exiftoolPath .. ' -rating "' .. file .. '" > ' .. tmpFileForRatingOutput)
  if (result ~= 0) then
    logger:error(' Error when writing rating to tmp file', result)
    return nil
  else
    local exiftoolOutput = readFile(tmpFileForRatingOutput)
    -- There are spaces around the number - tonumber gets rid of those spaces
    -- and converts to int. Mac has a single character, Windows has two, thus -3.
    return tonumber(exiftoolOutput:sub(-3))
  end
end

function readFile(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return content
end

main()
