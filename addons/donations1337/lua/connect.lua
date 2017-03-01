require("mysqloo")
if not db or not DBCONNECTED then
	db = mysqloo.connect( "sql11.freesqldatabase.com", "sql11161521", "T9JfbttuRW", "sql11161521", 3306 )

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