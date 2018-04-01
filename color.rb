class String
    def color(icing)
        if icing == "glaze"
            "\e[37m#{self}\e[0m"
        elsif icing =="chocolate"
            "\e[33m#{self}\e[0m"
        elsif icing =="straMberry"
            "\e[91m#{self}\e[0m"
        elsif icing =="lemon"
            "\e[93m#{self}\e[0m"
        elsif icing == "pistachio"
            "\e[92m#{self}\e[0m"
        end
    end
end


            puts "      MM".color("pistachio")
            puts "     MMMM".color("pistachio")
            puts "    MMMMMM".color("pistachio")
            
            print "M  "            
            print "MMMMMMMM".color("pistachio")
            print "  M"
            puts
            
            print "MM "            
            print "MMMMMMMM".color("pistachio")
            print " MM"
            puts
            
            print "MM "            
            print "MMMMMMMM".color("pistachio")
            print " MM"
            puts
            
            print "MMM"            
            print "MMMMMMMM".color("pistachio")
            print "MMM"
            puts
            
            print "MMMM"            
            print "MMMMMM".color("pistachio")
            print "MMMM"
            puts
            
            print "MMMMM"            
            print "MMMM".color("pistachio")
            print "MMMMM"
            puts
            
            print "MMMMMM"            
            print "MM".color("pistachio")
            print "MMMMMM"
            puts
            
            print "MMMMMMMMMMMMMM"
            puts
            print "MMMMMMMMMMMMMM"
            puts
            
            print " MMMMMM"            
            print "MMMMMM"
            puts
            
            print "  MMMMMMMMMM"            
            puts
            
            print "   MMMMMMMM"            
            puts
            
            print "    MMMMMM"            
            puts
            
            print "      MM"            
            puts