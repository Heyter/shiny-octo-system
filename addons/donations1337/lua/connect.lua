require("mysqloo")
dbpass = CreateConVar("DBPass","00000000",{FCVAR_PROTECTED,FCVAR_ARCHIVE},false)
DBCONNECTED = false


local function connect()
	if not mysqldb or not DBCONNECTED then
		mysqldb = mysqloo.connect( "db2.myarena.ru", "madbay_madbay", dbpass:GetString(), "madbay_madbay", 3306 )

		function mysqldb:onConnected()
			print("===DB Connected===")
			DBCONNECTED = true
		end
		function mysqldb:onConnectionFailed( err )

		    print( "Connection to database failed!" )
		    print( "Error:", err )

		end
		mysqldb:connect()
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