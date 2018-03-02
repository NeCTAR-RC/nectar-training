# sourced from https://gist.github.com/joelverhagen/1805814
# 20151015
class YouTube < Liquid::Tag
  Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then
      @id = $1

      if $2.nil? then
          @width = 560
          @height = 420
      else
          @width = $2.to_i
          @height = $3.to_i
      end
    else
      raise "No YouTube ID provided in the \"youtube\" tag"
    end
  end

  def render(context)
    # "<iframe width=\"#{@width}\" height=\"#{@height}\" src=\"http://www.youtube.com/embed/#{@id}\" frameborder=\"0\"allowfullscreen></iframe>"
 
    # 20151204 Luc: Modified to link to youtube videos when the layout is 'print' rather than embedding them.
    if context['page']['layout'] == 'print'
      "<a href=\"https://www.youtube.com/watch?v=#{@id}\">https://www.youtube.com/watch?v=#{@id}</a>"
    else
      "<iframe width=\"#{@width}\" height=\"#{@height}\" src=\"https://www.youtube.com/embed/#{@id}?color=white&theme=light\"></iframe>"
    end
  end

  Liquid::Template.register_tag "youtube", self
end
