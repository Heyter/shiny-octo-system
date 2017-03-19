require("mysqloo")
dbpass = CreateConVar("DBPass","00000000",{FCVAR_PROTECTED,FCVAR_ARCHIVE},false)
DBCONNECTED = false


local function connect()
	if not db or not DBCONNECTED then
		db = mysqloo.connect( "madbay.myarena.ru", "madbay_madbay", dbpass:GetString(), "madbay_madbay", 3306 )

		function db:onConnected()
			print("===DB Connected===")
			DBCONNECTED = true
		end
		function db:onConnectionFailed( err )

		    print( "Connection to database failed!" )
		    print( "Error:", err )

		end
		db:connect()
	end
end

timer.Create("Dbconnection",0.5,0,function()
	if DBCONNECTED then 
		timer.Stop("Dbconnection")
	end
	if dbpass:GetString() != "00000000" then
		connect()
	end

end)