--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--
--          =--Leaked by Teoren  --=             --
--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--

DOORHANDLE = {}

function InverseLerp( pos, p1, p2 )

	local range = 0
	range = p2-p1

	if range == 0 then return 1 end

	return ((pos - p1)/range)

end

