module Jekyll
	# usage: {% img src=</path/to/image>, w=<width>, h=<height>, 
	#     alt=<alt text> dim=<px|percent>, css=<extra css formatting> %}
	# All attributes except src are optional. Each argument has to be separated with a ','.
	# The dimension (argument dim) defines whether width is specified in pixels or percent of 
	# The page width (default: px). Height is always in pixels, unless unspecified (then it is autscaled with width)
	class ImgTag < Liquid::Tag

		def initialize(tag_name, params, tokens)
			super
			
			args = split_params(params)
	
			@alt=""		
			@src=""
			@img_style=""
			width=""
			height=""
			dim="px"
			css=""
			align=""
			for arg in args
				if args.length == 0 
					next
				end

				pair=arg.split('=').map(&:strip)
				
				if pair.size !=2
					raise "Error in image expression (Tag #{tag_name}), each argument must have a pair separated by '=', e.g. property=value. "+pair
				end
		

				#puts pair[0]+"-"+pair[1]

				case (pair[0])
				when "w"
					width=pair[1]
				when "h"
					height=pair[1]
				when "src"
					@src=pair[1]
				when "alt"
					@alt=pair[1]
				when "dim"
					dim=pair[1]
				when "css"
					css=pair[1]
				when "align"
					align=pair[1]
				end	
			end	
			
			if @src.length == 0
				raise "Error in image tag (Tag name #{tag_name}, at least a URL must be specified. "
			end
				
			if dim == "percent"
				dim="%"
			end

			if width.length > 0
				@img_style = "width:" + width + dim +"; "
			end
				
			if height.length > 0
				@img_style = @img_style + "height:#{height}px; "
			end


			@align_style=""

			if align.length > 0
				case align
				when "left"
					@align_style = "alignleft" #"display: inline; float:left; margin: 0 0 0 0; clear:both; "
				when "right"
					@align_style = "alignright" #"display: inline; float:right; margin: 0 0 0 0; clear:both; "
				when "center"
					@align_style = "aligncenter" # "display:block; margin:auto; clear:both; "
				end

			end
			
			#if @align_style.length > 0
			#	@img_style = @img_style + @align_style;
			#end

			if css.length > 0
				@img_style = @img_style + css;
			end
			
			#puts @src
			#puts @img_style
		end

		def render(context)
			style=""
			alt=""
			align=""
			if @img_style.length > 0 
				style="style=\"#{@img_style}\""
			end
			if @alt.length > 0
				alt="alt=\"#{@alt}\""
			end
			if @align_style.length > 0
				align="class=\"#{@align_style}\""
			end
			#"<p style=\"#{@align_style}\"><img src=\"#{@src}\" #{style} #{alt}/></p>"
			#"<span style=\"#{@align_style}\"><img src=\"#{@src}\" #{style} #{alt}/></span>"
			"<img src=\"#{@src}\" #{align} #{style} #{alt}/>"
		end
		
		def split_params(params)
			params.split(",").map(&:strip)
		end
	end
end

Liquid::Template.register_tag('img', Jekyll::ImgTag)
