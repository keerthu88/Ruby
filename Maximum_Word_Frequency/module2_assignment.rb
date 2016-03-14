#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)

  #Add the following methods in the LineAnalyzer class.
  def initialize (string,line_num)
    @line_number = line_num
    @content = string
    calculate_word_frequency
  end
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.

  def calculate_word_frequency
    array = @content.downcase.split(" ")
    hash = Hash.new(0)
    array.each{|word| hash[word] = hash[word] + 1}
    @highest_wf_count = hash.values.max
    hash = hash.to_a
    words = hash.select{|word| word[0] if word[1] == @highest_wf_count }
    @highest_wf_words = words.to_h.keys
    #puts "#{content} : #{highest_wf_words} count : #{highest_wf_count}"
  end
  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  def initialize
    @analyzers = []
  end
  def analyze_file
    file = File.open('test.txt','r') do |file|
      while line = file.gets
        @analyzers.push(LineAnalyzer.new(line,file.lineno))
      end
    end
  end

  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file

  def calculate_line_with_highest_frequency
    @highest_count_words_across_lines =[]
    @highest_count_across_lines = 0
    @analyzers.each do |analyser|  
      #puts "#{analyser.content} : #{analyser.highest_wf_words} count : #{analyser.highest_wf_count}"
      if highest_count_across_lines < analyser.highest_wf_count 
        @highest_count_across_lines = analyser.highest_wf_count 
      end
    end
   (@analyzers.select{ |analyser| @highest_count_words_across_lines.push(analyser) if analyser.highest_wf_count == highest_count_across_lines})
  end 
  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each do |analyser|
      #print analyser.highest_wf_words
      puts "#{analyser.highest_wf_words} (appears in line #{analyser.line_number}"
    end 
  end
end
