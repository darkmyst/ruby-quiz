class MadLibsGame
  def initialize(file_name)
    load_template(file_name)
    @story = ""
  end

  def load_template(file_name)
    @template = File.read(file_name)
    @story = ""
  end

  def gather_replacements
    puts "Please enter the following values:"
    keyed_values = Hash.new
    @story = @template.gsub(/\(\((?:(\w+):)?([^():]+)\)\)/) do |m|
      if keyed_values.has_key?($2)
        keyed_values[$2]
      else 
        print "  enter a '#{$2}': "
        value = STDIN.gets.chomp
        keyed_values[$1] = value if $1 != nil
        value
      end      
    end
    puts
  end
  
  def print_story
    puts @story
  end
end

unless ARGV.size == 1 and test(?e, ARGV[0])
  puts "Usage: #{File.basename($PROGRAM_NAME)} MADLIB"
  exit
end

game = MadLibsGame.new ARGV[0]
game.gather_replacements
game.print_story

