ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 600)
function OnTick()
	ts:update()
	if ValidTarget(ts.target) then
		for i = _Q, _R do
			CastSpell(i, ts.target)
		end
	end
end
