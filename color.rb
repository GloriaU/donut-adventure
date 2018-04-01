# String.color_samples

class String
    def color(icing)
        if icing == "glaze"
            "\e[7m#{self}\e[0m"
        elsif icing == "chocolate"
            "\e[3m#{self}\e[0m"
        elsif icing == "strawberry"
            "\e[61m#{self}\e[0m"
        elsif icing == "lemon"
            "\e[63m#{self}\e[0m"
        end
    end
end

# puts "Hello, World!".color("strawberry")

puts "\e[37mHello World\e[0m"

puts "\e[31mHello World\e[0m"

puts "\e[93mHello World\e[0m"

puts "\e[3mHello World\e[0m"