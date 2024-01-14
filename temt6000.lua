local temt6000 = {}

function temt6000.read()
	local raw = adc.read(0)
	if raw < 70 then
		return raw
	end
	if raw == 1024 then
		return 2500, raw
	end
	if raw < 300 then
		return (raw-70) * 2, raw
	end
	return raw * 2, raw
end

return temt6000
