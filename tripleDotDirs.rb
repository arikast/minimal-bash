#!/usr/bin/env ruby

require_relative 'lib/completion.rb'
include CompletionUtils

# complete -o bashdefault -o default -C $INSTALL_DIR/minimal-bash/tripleDotDirs.rb cd

syntax = ".../"


#puts point == line.length.to_s
levels = 0 
choices = []

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
        if File.directory? f then
            choices.push f
        end
    }
}

puts choiceResponse(choices)


