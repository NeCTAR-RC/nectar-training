module Jekyll
	module StripFrontmatterFilter
		def stripfrontmatter(input)
			# find first ---
			first = input.index("---")
			if (first == nil) 
				input
			end

			# second ---
			second = input.index("---", first + 1)
			if (second == nil)
				input
			end

			# strip the front matter
			input[first..second + 2] = ''
			
			# print result
			input
		end
	end
end
Liquid::Template.register_filter(Jekyll::StripFrontmatterFilter)
