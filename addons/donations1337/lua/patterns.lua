SQLPatterns = {}
SQLPatterns.sendPly 		= "INSERT INTO players (`steamid`, `steamid64`, `usergroup`, `firstjoined`) VALUES(?, ?, ?, ?)"
SQLPatterns.selPly 			= "SELECT * FROM players WHERE `steamid` = ?"
SQLPatterns.sendLog			= "INSERT INTO log (`time`,`entry`) VALUES (?, ?)"
SQLPatterns.getpending 		= "SELECT * FROM pending WHERE status = 0"
SQLPatterns.updatePStatus 	= "UPDATE pending SET `status` = 1 WHERE `id` = ?"