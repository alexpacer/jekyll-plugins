
module Jekyll
  @Pages = nil
  @RootNode = nil
  class << self; attr_accessor :Pages; attr_accessor :RootNode; end
  
  class TreeDirTag < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @root_url = ''
      if markup.strip =~ /\s*root:(.+)/i
        @root_url = $1
        markup = markup.strip.sub(/root:(.+)/i,'')
      end
      super
    end
    
    def render(context)
      html = ''
      Jekyll.Pages = context.registers[:site].pages
      #Jekyll.Pages.each{|p| Jekyll.RootNode = p if /^\/index\..+$/.match(p.url) }      # find root node first
      Jekyll.RootNode = Jekyll.Pages.select{|p| p.url == @root_url }.first
      
      puts "~~"
      puts Jekyll.Pages.select{|p| p.url == @root_url }.first.url


      puts "---render---"
      puts "root: #{Jekyll.RootNode}"
      puts ""
      puts ""
      Jekyll.Pages.reject{|c| c.level < 0 }
        .sort{|a,b| a.level <=> b.level }
        .each{|p| 
          puts "Level: #{p.level} :: #{p.url}" 
          if !p.parent.nil?
            puts " has parent #{p.parent} :: #{p.parent.url}"
          end
        }
      
      # Jekyll.Pages.each do |p|
      #         title = p.data['title']
      #         puts "-----page ----"
      #         html << "<a href='#{p.url}' class='page-tree-link'>#{title}</a> <br />"
      #         puts "Page #{p.url} at level:#{p.level} has following children "
      #         #puts p.parent.url if !p.parent.nil?
      #         # p.children.each{|c|
      #         #   puts "  -#{c.url}" if !c.nil?
      #         # }
      #       end
      
      html
    end
  end

  
  # Implement SimpleTree
  # 
  class Page
    include SimpleTree
    
    # Number of slash(s) will determine the current level if where the page sits
    def level
      self.url.scan(/\//).size - Jekyll.RootNode.url.scan(/\//).size
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
        end
        nil
      end
    end
    
    # Returns all childern elements of this current page
    # 
    def children()
      if self == Jekyll.RootNode
        return Jekyll.Pages.collect do |p|
          p
        end
      else
      end
      # if self == Jekyll.RootNode # retrieve all child pages fir /index.*
      #   return Jekyll.Pages.collect do |p|
      #     p if p.url.scan(/\//).size == 2 && p.url != Jekyll.RootNode.url
      #   end
      # else
      #   # The sigment of the current page, say "/bio/about.html", the sigment would be "/bio/"
      #   sig = /^(\/[^\/]+)\//.match(self.url)
      #   return Jekyll.Pages.collect do |p|
      #     # if the page's url has current page's sigment, and it's not current page
      #     p if sig && /^#{sig[0]}[^index]/.match(p.url) && self != p
      #   end
      # end
    end
    
  end

end



Liquid::Template.register_tag('tree_dir', Jekyll::TreeDirTag)





