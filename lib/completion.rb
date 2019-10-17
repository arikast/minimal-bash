module CompletionUtils

def longestCommonPrefix(choices)
    "../../"
end

def choiceResponse(choices)
    if choices.size <= 1 then
        choices.join "\n"
    else
        longestCommonPrefix(choices)
    end
end

CompletionInput = Struct.new(:subject, :priorWord, :textSoFar, :line, :wordBreaks, :point, :kast) do 
   def initialize()
        #puts ENV['COMP_TYPE']
        ## the command that triggered the completion
        self.subject = ARGV[0]
        self.priorWord = ARGV[1]
        self.textSoFar = ARGV[2]
        ## entire line including subject
        self.line = ENV["COMP_LINE"]
        self.wordBreaks = ENV["COMP_WORDBREAKS"]
        ## the length of line.  equivalent to line.length.to_s
        self.point = ENV["COMP_POINT"]
   end 
end

end
