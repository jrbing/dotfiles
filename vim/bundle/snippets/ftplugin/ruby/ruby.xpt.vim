" Personal ruby snippets file
XPTemplate priority=personal

" containers
let s:f = g:XPTfuncs()

XPT rdoc syn=comment " RDoc description
=begin rdoc
# `cursor^
#=end
# Converts the object into textual markup given a specific format.
#
# @param format [Symbol] the format type, `:text` or `:html`
# @return [String] the object converted into the expected format.
