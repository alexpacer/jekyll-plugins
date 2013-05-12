jekyll-plugins
==============

Collection of Jekyll plugins custom made

# Tree Dir Tag
Specify a root index directory (index.html) and the tag will traverse through sub directory structure and output a HTML UL>LI list.

## Usage
- This plugin needs a root directory/page.
- This plugin only supports directory-page style in Jekyll, a single [page-name].html page will not work with this plugin.

## Parameter

### * tree_ignore_link

`true` if this page is not to be linked in listed menu, the link hre will be `#`.   

  Useful when this page is only to provide a category-like section  
  default to `false`  
  **Usage**  
  ```
  ---
  layout: default
  title: Dir 3
  tree_ignore_link: true
  ---
  ```
  

## Example

To use the tag in template:

```html
<div id="dir">
	{% tree_dir_tag root:/dir/index.html %}
</div>
```

# LICENSE
see [license](https://github.com/alexpacer/jekyll-plugins/blob/master/LICENSE)

## Dependencies

### SimpleTree

This plugin take use of [SimpleTree](https://github.com/ealdent/simple-tree) module created by [Jason M. Adams](https://github.com/ealdent) That turns Jekyll::Page into tree-aware-node.

The module is located in `/_plugins/simple_tree.rb`

Please see following LICENSE information for the simple-tree module

---

Copyright (c) 2008, Jason M. Adams
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * The name of Jason M. Adams may not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.