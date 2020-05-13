do
	getText = translations[tfm.get.room.community]
	if getText then
		-- TODO: merge EN
	else
		getText = translations.en
	end

	translations = nil
end