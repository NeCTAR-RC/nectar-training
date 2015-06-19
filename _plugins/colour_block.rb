module Jekyll
  module Tags

	  # usage: <% col r,g,b %> text <% endcol %>, for example {%col 255,0,0 %} 
	  # text in red {% endcol %}
	class ColourBlock < Liquid::Block
		r=0
		g=0
		b=0
	 	content=""

		def initialize(tag_name, params, tokens)
			args = split_params(params)
			if args.length >= 3
			   @r = args[0]
			   @g = args[1]
			   @b = args[2]
			end
			super
        	end

		def render(context)
			contents=super(context)
			#puts contents
			# to enable conversion of the text from markdown to html, we would have to
			# remove the surrounding <p> tags which cause problems if within
			# the span tag (the raw html is then shown intsead of the formatted text).
			# For now, formatting of inner text is skipped.
			#site = context.registers[:site]
			#converter = site.getConverterImpl(Jekyll::Converters::Markdown)
			#output = converter.convert(contents)
			#"{% raw %} <span style='color: rgb(#{@r},#{@g},#{@b});'> #{contents} </span> {% endraw %}"
			"<span markdown style='color: rgb(#{@r},#{@g},#{@b});'>"+contents+"</span>"
		end

		def split_params(params)
			params.split(",").map(&:strip)
		end


	end
  end
end

Liquid::Template.register_tag('col', Jekyll::Tags::ColourBlock)
