AddCSLuaFile()
module("voicechannel", package.seeall)

local Band = {}

function Band:__construct(id, flags)
    self.Mics = {}
    self.Speakers = {}

    hook.Add("PlayerCanHearPlayersVoice", "MediaChannel" .. id, function(ply1, ply2)
        if self:CanHearFrom(ply2, ply1) then
            return true
        end
    end)
end

function Band:Register(channel, ent, isSpeaker, isMicrophone)
    if not self.Mics[channel] then
        self.Mics[channel] = {}
        self.Speakers[channel] = {}
    end

    if isMicrophone then
        self.Mics[channel][ent] = true
    end
    if isSpeaker then
        self.Speakers[channel][ent] = true
    end
end

function Band:Unregister(channel, ent)
    if not self.Mics[channel] then
        return
    end

    self.Mics[channel][ent] = nil
    self.Speakers[channel][ent] = nil

    if table.Count(self.Mics[channel]) == 0 and table.Count(self.Speakers[channel]) == 0 then
        self.Mics[channel] = nil
        self.Speakers[channel] = nil
    end
end

function Band:CanHearFrom(broadcaster, listener)
    for chanID, ents in pairs(self.Mics) do
        for ent, _ in pairs(ents) do
            if IsEntity(ent) and ent:InMicrophoneRange(broadcaster) then
                -- Now let's see if the listener can listen to this channel
                if self:Hears(chanID, listener) then
                    return true
                end
            end
        end
    end

    return false
end

function Band:Hears(channel, listener)
    if not self.Speakers[channel] then
        return false
    end

    for ent, _ in pairs(self.Speakers[channel]) do
        if IsEntity(ent) and ent:InSpeakerRange(listener) then
            return true
        end
    end

    return false
end

local bands = {}

function CreateBand(id, flags)
    if bands[id] then
        return bands[id]
    end

    local flags = flags or 0
    local instance = {}
    setmetatable(instance, { __index = Band })
    Band.__construct(instance, id, flags)
    bands[id] = instance
    return instance
end


function GetBand(id)
    if bands[id] then
        return bands[id]
    end

    Error("Band " .. id .. " is not defined")
end
