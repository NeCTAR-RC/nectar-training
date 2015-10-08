module Jekyll
  module Tags

	  # Usage: {% BgBox <type> %} Text of info box {% endBgBox %}```
	  # Replacing <type> with either 
	  # * info
	  # * important or
	  # * definition
	  # * edit
	  # * terminal
	  # * prerequisite
	  # to create different types.
  	  class BackgroundBox < Liquid::Block
		boxType = "notype"

		def initialize(tag_name, params, tokens)
			@boxType="notype"

			args = split_params(params)

			if args.length >= 1
			   @boxType = args[0].downcase
			end
			#puts params
			#puts args
			super
        	end

		def render(context)
			site = context.registers[:site]
			converter = site.getConverterImpl(Jekyll::Converters::Markdown)
			content=super(context)
			output = converter.convert(super(context))
			content=content.strip
      baseurl = context.registers[:site].baseurl
			case @boxType 
			when "info"
				"<div markdown class='bgInfo'>
			        	<img src='#{baseurl}/images/glyphicons-196-circle-info.png' align='left' style='width:26px; height:26px; 
					  margin:0px; margin-right:10px; margin-bottom:5px;'/>
					#{output}
				</div>"
			when "important"
				"<div markdown class='bgImportant'>
			        	<img src='#{baseurl}/images/glyphicons-197-circle-exclamation-mark.png' align='left' style='width:26px; height:26px; 
					  margin:0px; margin-right:10px; margin-bottom:5px;'/>
					#{output}
				</div>"
			when "definition"
				"<div markdown class='bgDefinition' style='min-height: 55px;'>
			        	<img src='#{baseurl}/images/glyphicons-352-book-open.png' align='left' 
					style='width:24px; height:22px;
					margin:0px; margin-right:10px; margin-bottom:5px;'/>
					#{output}
				</div>"
			when "edit"
				"<div class='bgEdit'><pre class='PreformatEdit'>#{content}</pre></div>"
			when "terminal"
				"<div class='bgTerminal'><pre class='PreformatTerminal'>#{content}</pre></div>"
			when "prerequisite"
				"<div markdown class='bgPrerequisite'>
			        	<img src='#{baseurl}/images/glyphicons-333-certificate.png' align='left' style='width:17px; height:26px; 
					  margin:0px; margin-right:10px; margin-bottom:5px;'/>
					#{output}
				</div>"
			else 
				sourcefile=context.registers[:site].source
				raise "Unknown Background box type: "+@boxType+" - "+sourcefile
			end
		end

		def split_params(params)
			params.split(",").map(&:strip)
		end
	end
  end
end

Liquid::Template.register_tag('BgBox', Jekyll::Tags::BackgroundBox)
