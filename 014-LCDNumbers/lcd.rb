
class LCD
  VERTICAL_CHAR = "|"
  HORIZONTAL_CHAR = "-"
  WHITESPACE_CHAR = " "
  DIVIDER_CHAR = " "

  LCD_NUMBERS = [
    [[1],[1,1],[0],[1,1],[1]], # 0
    [[0],[0,1],[0],[0,1],[0]], # 1
    [[1],[0,1],[1],[1,0],[1]], # 2
    [[1],[0,1],[1],[0,1],[1]], # 3
    [[0],[1,1],[1],[0,1],[0]], # 4
    [[1],[1,0],[1],[0,1],[1]], # 5
    [[1],[1,0],[1],[1,1],[1]], # 6
    [[1],[0,1],[0],[0,1],[0]], # 7
    [[1],[1,1],[1],[1,1],[1]], # 8
    [[1],[1,1],[1],[0,1],[1]], # 9
    [[1],[1,0],[1],[1,0],[1]]  # NOT A NUMBER
  ]

  def initialize(number_string)
    @number_string = number_string
  end

  def print(size=1)
    numerals = @number_string.split("").map do |num_char|
      number = num_char.to_i
      if number == 0 and num_char != "0"
        LCD_NUMBERS[10]
      else
        LCD_NUMBERS[number]
      end
    end 

    output = ""
    (0..4).each do |row|
      if row % 2 == 0
        output += print_horizontal(numerals, row, size) 
      else 
        output += print_vertical(numerals, row, size)
      end
    end
    puts output
    puts
  end

  def print_vertical(numerals, row, size)
    output = ""
    vertical_stretch_count = 0 
    while vertical_stretch_count < size do
      numerals.each do |num|
        if num[row][0] == 1
          output += VERTICAL_CHAR
        else 
          output += WHITESPACE_CHAR
        end
        output += WHITESPACE_CHAR * size 
        if num[row][1] == 1
          output += VERTICAL_CHAR
        else 
          output += WHITESPACE_CHAR
        end
        output += DIVIDER_CHAR
      end
      output += "\n"
      vertical_stretch_count+=1
    end
    output
  end

  def print_horizontal(numerals, row, size)
    output = ""
    numerals.each do |num|
      output += WHITESPACE_CHAR 
      output += (num[row][0] == 1 ? HORIZONTAL_CHAR : WHITESPACE_CHAR) * size
      output += WHITESPACE_CHAR
      output += DIVIDER_CHAR
    end
    output += "\n"
  end
end

if ARGV.size == 0
  puts "USAGE: #{File.basename($PROGRAM_NAME)} [-s size] DISPLAY"
  exit
elsif ARGV[0] == "-s"
  size = ARGV[1].to_i
  display = ARGV[2]
else
  size = 1
  display = ARGV[0]
end

lcd = LCD.new display
lcd.print size
