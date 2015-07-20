module Jekyll
  module Tags

	  # Usage: {% review <your-name> %} Text of review {% endreview %}```
  	  class ReviewBox < Liquid::Block
		name = "notype"

		def initialize(tag_name, params, tokens)
			@name="unknown"

			args = split_params(params)

			if args.length >= 1
			   @name = args[0]
			end
			super
        	end

		def render(context)
			#site = context.registers[:site]
			#converter = site.getConverterImpl(Jekyll::Converters::Markdown)
			content=super(context)
			#output = converter.convert(super(context))
			content=content.strip
			"<div class='review'><b style='color:red'>Review comment by "+@name+"</b><br><pre class='PreformatReview'>#{content}</pre></div>"
		end

		def split_params(params)
			params.split(",").map(&:strip)
		end
	end
  end
end

Liquid::Template.register_tag('review', Jekyll::Tags::ReviewBox)
