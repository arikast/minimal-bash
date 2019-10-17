#!/usr/bin/env ruby

require_relative 'lib/completion.rb'
include CompletionUtils

# complete -o bashdefault -o default -C $INSTALL_DIR/minimal-bash/tripleDotDirs.rb cd

syntax = ".../"


#puts point == line.length.to_s
levels = 0 
choices = []
uniqFileNames = {} 

input = CompletionInput.new

if ! input.priorWord.start_with?(syntax) then
    puts ""
    exit
else
    input.priorWord = input.priorWord[".../".length, input.priorWord.length]
end

Dir.pwd.sub(/^\//, '').split('/').reverse.each { |s| 
    levels +=1 
    prefix = "../" * levels
    Dir["#{prefix}#{input.priorWord}*"].each{|f| 
        cf = chompParentPath(f)
        if uniqFileNames[cf].nil? and File.directory? f then
            choices.push f
            uniqFileNames[cf]=1
        end
    }
}

if choices.size <= 1 then
    puts choices.join "\n"
else
    #puts longestCommonPrefix(choices)
    puts choices.map{|c| subParentPath(c, syntax)}
end

