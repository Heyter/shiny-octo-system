SQLPatterns = {}

SQLPatterns.getpending 		= "SELECT * FROM pending WHERE `status` = 0 AND `addedon` < ?"
SQLPatterns.selPly 			= "SELECT * FROM players WHERE `steamid` = ?"
SQLPatterns.checkPending	= "SELECT * FROM pending WHERE `steamid64` = ? AND `addedon` > ? AND `status` = 0 AND `type` = ? AND `addargs` = ?"
SQLPatterns.sendLog			= "INSERT INTO log (`time`,`entry`) VALUES (?, ?)"
SQLPatterns.sendPly 		= "INSERT INTO players (`steamid`, `steamid64`, `usergroup`, `firstjoined`) VALUES(?, ?, ?, ?)"
SQLPatterns.addPending		= "INSERT INTO pending (`steamid64`, `addedon`, `type`, `addargs` ) VALUES (?, ?, ?, ?)"
SQLPatterns.updatePStatus 	= "UPDATE pending SET `status` = 1 WHERE `id` = ?"
SQLPatterns.updatePending	= "UPDATE pending SET `addedon` = ? WHERE `id` = ?"
SQLPatterns.updateUGroup	= "UPDATE players SET `usergroup` = ? WHERE `steamid64` = ?"
SQLPatterns.updatePWeps		= "UPDATE players SET `permaweapons` = ? WHERE `steamid64` = ?"


allowedPWeapons = {
	
m9k_luger
,m9k_coltpython
,m9k_ragingbull
,m9k_model3russian
,m9k_model500
,m9k_m29satan
,m9k_deagle
,m9k_scoped_taurus
,m9k_model627
,m9k_m92beretta
,m9k_sig_p229r
,m9k_hk45
,m9k_colt1911
}
