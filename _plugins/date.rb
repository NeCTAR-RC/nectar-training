module Jekyll
	module DateFilter
		def file_date(input)
		File.mtime(input).strftime("%Y-%m-%d")
		end
	end
end

Liquid::Template.register_filter(Jekyll::DateFilter)
