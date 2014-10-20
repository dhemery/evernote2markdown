#!/usr/bin/env ruby
require 'fileutils'

evernote_html_dir = 'from-evernote'
intermediate_dir = 'intermediate'
markdown_dir = 'markdown'

def is_note_file(fname)
  return false unless fname[0] =~ /[[:alnum:]]/
  return false unless File.file?(File.join('from-evernote', fname))
  File.extname(fname) == '.html'
end

def intermediate_file_for(fname)
  File.basename(fname, '.html').downcase.scan(/[[:alnum:]]*/).select{|s| !s.empty?}.join('-') + '.html'
end

def markdown_file_for(fname)
  File.basename(fname, '.html').downcase.scan(/[[:alnum:]]*/).select{|s| !s.empty?}.join('-') + '.md'
end

FileUtils.mkdir_p intermediate_dir
FileUtils.mkdir_p markdown_dir
entries = Dir.entries(evernote_html_dir).select{|f| is_note_file f}

entries.each do |entry|
  html = File.join(evernote_html_dir, entry)
  intermediate = File.join(intermediate_dir , intermediate_file_for(entry))
  markdown = File.join(markdown_dir, markdown_file_for(entry))
  FileUtils.cp_r html, intermediate
  `sed -E -i '' -f patch-html #{intermediate}`
  `pandoc --no-wrap -s "#{intermediate}" -o #{markdown}`
  `sed -i '' -f patch-markdown #{markdown}`
  `sed -i '' -f collapse-blank-lines #{markdown}`
end
