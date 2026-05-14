local HttpService = game:GetService("HttpService");

local CONFIG_FOLDER = "ModalConfigs"
local AUTOLOAD_FILE = CONFIG_FOLDER .. "/autoload.txt"

local Config = {}

local function EnsureFolder()
	if not isfolder(CONFIG_FOLDER) then
		makefolder(CONFIG_FOLDER);
	end
end

Config.Save = function(Name: string, Data: {[string]: any}): boolean
	EnsureFolder();
	local Path = CONFIG_FOLDER .. "/" .. Name .. ".json"
	local OK, Encoded = pcall(HttpService.JSONEncode, HttpService, Data);

	if OK then
		writefile(Path, Encoded);
		return true
	end

	return false
end

Config.Load = function(Name: string): ({[string]: any}?)
	local Path = CONFIG_FOLDER .. "/" .. Name .. ".json"

	if isfile(Path) then
		local OK, Decoded = pcall(HttpService.JSONDecode, HttpService, readfile(Path));
		if OK then
			return Decoded
		end
	end

	return nil
end

Config.Delete = function(Name: string)
	local Path = CONFIG_FOLDER .. "/" .. Name .. ".json"
	if isfile(Path) then
		delfile(Path);
	end
end

Config.List = function(): {string}
	EnsureFolder();
	local Files = listfiles(CONFIG_FOLDER);
	local Configs = {};

	for _, File in Files do
		local Name = File:match("([^/\\]+)%.json$");
		if Name then
			table.insert(Configs, Name);
		end
	end

	return Configs
end

Config.SetAutoLoad = function(Name: string)
	EnsureFolder();
	writefile(AUTOLOAD_FILE, Name);
end

Config.GetAutoLoad = function(): string?
	if isfile(AUTOLOAD_FILE) then
		local Content = readfile(AUTOLOAD_FILE):gsub("%s+", "");
		return (Content ~= "" and Content) or nil
	end
	return nil
end

Config.RemoveAutoLoad = function()
	if isfile(AUTOLOAD_FILE) then
		delfile(AUTOLOAD_FILE);
	end
end

Config.Exists = function(Name: string): boolean
	return isfile(CONFIG_FOLDER .. "/" .. Name .. ".json");
end

return Config
