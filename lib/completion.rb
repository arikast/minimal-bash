module CompletionUtils

def min(a, b)
    if b < a then
        b
    else
        a
    end
end

def commonPrefix(a, b)
    len = min(a.length, b.length)

    0.upto(len - 1).each {|i|
        if a[i] != b [i] then
            return a[0..i]
        end
    }
    return a[0..len]
end

def longestCommonPrefix(choices)
    if choices.size == 1 then
        return choices[0]
    end

    best = choices[0] 
    1.upto(choices.size() -1).each {|c|
        best = commonPrefix(best, choices[c]) 
    }
    return best
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
