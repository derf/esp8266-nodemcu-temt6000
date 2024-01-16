local temt6000 = {}

function temt6000.read()
	return adc.read(0)
end

return temt6000
