#!/usr/bin/env ruby

# complete -o bashdefault -o default -C $INSTALL_DIR/minimal-bash/tripleDotFiles.rb mv
# complete -o bashdefault -o default -C $INSTALL_DIR/minimal-bash/tripleDotFiles.rb cp 
# complete -o bashdefault -o default -C $INSTALL_DIR/minimal-bash/tripleDotFiles.rb ls

#puts ENV['COMP_TYPE']

## the command that triggered the completion
subject = ARGV[0]
priorword = ARGV[1]
textsofar = ARGV[2]
## entire line including subject
line = ENV["COMP_LINE"]
wordbreaks = ENV["COMP_WORDBREAKS"]
## the length of line.  equivalent to line.length.to_s
point = ENV["COMP_POINT"]

#puts point == line.length.to_s
levels = -1
choices = []

if ! priorword.start_with?(".../") then
    puts ""
    exit
else
    priorword = priorword[".../".length, priorword.length]
end

Dir.pwd.sub(/^\//, '').split('/').reverse.each { |s| 
    levels +=1 
    prefix = "../" * levels
    choices.push(Dir["#{prefix}#{priorword}*"].map {|f| 
        #f[prefix.length,-1]
        f
    })
}
puts choices
