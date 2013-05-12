
module Jekyll
  @Pages = nil
  @RootNode = nil
  class << self; attr_accessor :Pages; attr_accessor :RootNode; end
  
  class TreeDirTag < Liquid::Tag
    
    # Retrieve root element configuration
    #
    def initialize(tag_name, markup, tokens)
      @root_url = ''
      if markup.strip =~ /\s*root:(.+)/i
        @root_url = $1
        markup = markup.strip.sub(/root:(.+)/i,'')
      end
      super
    end
    
    def render(context)
      html = '<ul>'
      Jekyll.Pages = context.registers[:site].pages
      Jekyll.RootNode = Jekyll.Pages.select{|p| p.url == @root_url }.first
      html << traverse_tree(Jekyll.Pages.select{|c| c.level == 0 }.first)
      html << '</ul>'
      html
    end
    
    # Helps traverse tree structure into UL-LI list in html form
    #
    def traverse_tree(node)
      href = (node.data['tree_ignore_link'] ||= false) ? '#' : node.url
      str = "<li><a href='#{href}'>#{node.data['title']}</a>"
      if node.has_children?
        str << "<ul>"
        node.children.each{|c| str << traverse_tree(c) }
        str << "</ul>"
      end
      str << "</li>"
      str
    end
    
  end

  
  # Implement SimpleTree in Jekyll::Page object
  # 
  class Page
    include SimpleTree
    
    # Number of slash(s) will determine the current level if where the page sits
    def level
      sig = /(\/[^\/]+\/)index..+$/.match(Jekyll.RootNode.url)[1]
      if self.url.match(/#{sig}/)
        return self.url.scan(/\//).size - Jekyll.RootNode.url.scan(/\//).size
      end
      -666
    end
    
    # Retrieve the parent if parent is not null
    #
    def parent()
      # returns nil if it's root page
      if self == Jekyll.RootNode
        return nil
      else
        #last sigment of the page
        last_sig = /(\/([^\/]+))?\/([^\/]+)$/.match(self.url){|m| m }
        parent_name = /(\/[^\/]+)#{last_sig}$/.match(self.url)[1] + "/"
        Jekyll.Pages.select do |p|
          p.level == (self.level-1) && /#{parent_name}index\..+/.match(p.url)
        end.first
      end
    end
    
    # Returns all childern elements of this current page
    # 
    def children()
      # The signature of current node
      sig = /(\/[^\/]+\/)index..+$/.match(self.url)[1]
      Jekyll.Pages.select do |p|
        p.level == (self.level + 1) && /#{sig}[^\/]+\/index..+$/.match(p.url) # 1 level lower and has signature before the node
      end
    end
    
  end

end

Liquid::Template.register_tag('tree_dir_tag', Jekyll::TreeDirTag)

