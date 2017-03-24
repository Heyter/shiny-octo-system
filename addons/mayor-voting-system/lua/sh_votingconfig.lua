VOTING.Theme = {}
--
-- Mayor Voting Theme
--

VOTING.Theme.WindowColor = Color(84,57,34,255) --Main window color
VOTING.Theme.ControlColor = Color( 38, 41, 49, 255) --Main window control color
VOTING.Theme.TitleTextColor = color_white --Main title text color

VOTING.Theme.NoticePrefixColor = Color(255,51,51) --Chat text color of notice prefix
VOTING.Theme.NoticeTextColor = Color(245, 206, 34 ) --Chat text color of notices

VOTING.Settings = {}
--
-- Mayor Voting Settings
--
VOTING.Settings.VotingTitle = "Выборы Мэра" --Main title
VOTING.Settings.ResultsTitle = "Новый мэр!" --Main title for results
VOTING.Settings.NoticePrefix = "( ВЫБОРЫ ) " --Chat text prefix

VOTING.Settings.NPCEnabled = true --Spawn Mayor Elections NPC?
VOTING.Settings.NPCTitleText = "Стать мэром" --NPC Title above head
VOTING.Settings.NPCModel = "models/player/mossman.mdl" --NPC Player model
VOTING.Settings.NPCSequence = "pose_standing_01" --NPC pose default pose_standing_01

VOTING.Settings.CloseTimeAfterVoteEnds = 8 --Time until window closes after results
--The vote ticker shows real-time updates of who is voting for who
VOTING.Settings.ShowVoteTickerUpdates = true --Show vote ticker?
VOTING.Settings.ForceMouseCursor = false --Force mouse cursor on for new votes?

VOTING.Settings.MenuSounds = true --Play the menu sounds?
VOTING.Settings.NewVoteSound = "plats/elevbell1.wav" --New vote sound
VOTING.Settings.VoteResultsSound = "ui/achievement_earned.wav" --Vote results sound

--
-- Mayor Voting Configuration Options
--

VOTING.MayorTeamName = "Мэр" --DarkRP mayor team name i.e. (name after AddExtraTeam)
VOTING.MaximumCandidates = 4 --Maximum candidates allowed in vote
VOTING.MinimumCandidates = 2 --Minimum candidates needed to trigger vote
VOTING.AboutToBeginTime = 60 --Time (in seconds) between vote triggered and started
VOTING.VoteTime = 20 --Time (in seconds) that a vote will last
VOTING.AllowCandidatesToVote = true --Allow candidates to participate in the vote?
VOTING.OnlyEnterUsingNPC = true --Only allow vote entry using the NPC?
VOTING.CandidateCost = 250 --Cost of vote entry. Set to 0 to disable entry fee.
VOTING.DemoteMayorOnDeath = true --Demote the mayor automatically if they die.
VOTING.MinutesUntilNextElection = 60 --Cooldown (in minutes) for new mayor vote
VOTING.AllowNewElectionOnDeath = true --Reset cooldown if the mayor dies
VOTING.AllowNewElectionWithMayor = true --Allow new votes if there is already a mayor
VOTING.DemoteOtherMayorsOnWin = true --Demote current mayors when there is a new mayor

--Custom Vote Entry Check
--Developers can also add a custom vote entry check, this will be called when
--a player tries to enter the mayor election. Return true/false to allow/disallow.
--You can also set a custom failure message to show to the player.
--Example
//VOTING.CanEnterVotingCustomFunction = function(ply) if ply:Level() > 5 then return true end end
//VOTING.CustomFunctionFailed = "You are not high enough level to enter a mayor election!"
