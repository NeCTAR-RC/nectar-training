module Jekyll
  module Tags

	  # Usage: {% BgBox <type> %} Text of info box {% endBgBox %} {% endraw %}```
	  # Replacing <type> with either 
	  # * info
	  # * important or
	  # * definition
	  # * edit
	  # * terminal
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
			case @boxType 
			when "info"
				"<div markdown class='bgInfo'>
			        	<img src='/images/info-32.png' align='left' 
					style='width:32px; height:32px; 
					  margin:0px; margin-right:10px; margin-bottom:5px;'/>
					#{output}
				</div>"
			when "important"
				"<div markdown class='bgImportant'>
			        	<img src='/images/exclamation-32.png' align='left' 
					style='width:32px; height:32px; 
					  margin:0px; margin-right:10px; margin-bottom:5px;'/>
					#{output}
				</div>"
			when "definition"
				"<div markdown class='bgDefinition' style='min-height: 55px;'>
			        	<img src='/images/definition-64.png' align='left' 
					style='width:64px; height:50px;
					margin:0px; margin-right:10px; margin-bottom:5px;'/>
					#{output}
				</div>"
			when "edit"
			        #<img src='/images/document-edit-48.png' align='left' 
				#	style='width:24px; height:24px;
				#	margin:0px; margin-right:5px; margin-bottom:5px;'/>
				"<div markdown class='bgEdit'>
					#{output}
				</div>"
			when "editpreformat"
				"<div markdown class='bgEdit'>
				        <pre class='PreformatEdit'>
					#{content}
					</pre>
				</div>"
			when "terminal"
				"<div markdown class='bgTerminal'>
					#{output}
				</div>"
			when "terminalpreformat"
				"<div markdown class='bgTerminal'>
				        <pre class='PreformatTerminal'>
					#{content}
					</pre>
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
