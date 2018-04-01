# our happy little donut is going on an advneture

require 'highline'
require 'ruby_mud'

class Foes
    attr_reader :foe_type, :foe_name, :foe_damage, :foe_accuracy
    attr_accessor :foe_health
    def initialize(foe_type,foe_name,foe_damage,foe_health,foe_accuracy)
        @foe_type = foe_type
        @foe_name = foe_name
        @foe_damage = foe_damage
        @foe_health = foe_health
        @foe_accuracy = foe_accuracy
    end
    def stats
        puts "Type: #{@foe_type}"
        puts "Name: #{@foe_name}"
        puts "Damage: #{@foe_damage}"
        puts "Health: #{@foe_health}"
    end
end

dinosaur = Foes.new("dinosaur","Kitty",2,5,5)
human = Foes.new("hungry human","Taylor Want",3,4,8)
rock = Foes.new("rock","Rocky",4,8,3)
pistachio = Foes.new("pistachio","Gloria",7,3,6)

class String
    def color(icing)
        if icing == "glaze"
            "\e[37m#{self}\e[0m"
        elsif icing =="chocolate"
            "\e[33m#{self}\e[0m"
        elsif icing =="strawberry"
            "\e[91m#{self}\e[0m"
        elsif icing =="lemon"
            "\e[93m#{self}\e[0m"
        elsif icing == "pistachio"
            "\e[92m#{self}\e[0m"
        end
    end
end

class Donut
    attr_reader :name, :icing
    attr_accessor :self_defense, :health, :attack_damage, :evasion
    def initialize(name,icing,self_defense)
        @name = name
        @icing = icing
        @self_defense = self_defense
        @health = 10
        if @self_defense == "spear"
            @attack_damage = 6
            @evasion = 3
        elsif @self_defense == "sword"
            @attack_damage = 4
            @evasion = 4
        elsif @self_defense == "fly swatter"
            @attack_damage = 3
            @evasion = 7
        elsif @self_defense == "muscles"
            @attack_damage = 2
            @evasion = 7
        end
    end
end


def beginning()
    puts "Dear donut owner, your little pretty friend is about to suffer a dangerous encounter with several enemies. We are sad to announce that your donut may lose their life. If you refuse to let your mascot fight, leave this game immediately. Would you like to stay and be a brave warrior?"
        answer = gets.chomp.downcase
        puts
    if answer != "yes"
        puts "Bye. Have a good one."
    else
        puts "First let's ask some questions to the donut owner: What is the name of your donut?"
        $name = gets.chomp.capitalize
        puts
        
        puts "What is your icing?"
        icingchoice = HighLine.new
        # HighLine::Menu.index_color   = :rgb_99ccaa # set default index color
        
        icingchoice.choose do |menu|
            menu.index        = :letter
            menu.index_suffix = ") "
        # menu.index_color = :pink              # override default color of index
                                               # you can also use constants like :blue
            menu.choice(:glaze) do $icing = "glaze" end
            menu.choice(:chocolate) do $icing = "chocolate" end
            menu.choice(:strawberry) do $icing = "strawberry" end
            menu.choice(:lemon) do $icing = "lemon" end
        end
        puts
        
        puts "What is your donut's weapon?"
        weaponchoice = HighLine.new
        # HighLine::Menu.index_color   = :rgb_99ccaa # set default index color
        
        weaponchoice.choose do |menu|
            menu.index        = :letter
            menu.index_suffix = ") "
        # menu.index_color = :pink          # override default color of index
                                            # you can also use constants like :blue
            menu.choice(:spear) do $weapon = "spear" end
            menu.choice(:sword) do $weapon = "sword" end
            menu.choice(:swatter, "fly swatter") do $weapon = "fly swatter" end
            menu.choice(:muscles) do $weapon = "muscles" end
        end
          
        puts "Is this information correct?
        Name: #{$name}
        Icing: #{$icing}
        Weapon: #{$weapon}
        Health: 10"
        answer2 = gets.chomp
        if answer2 == "yes"
            $player = Donut.new($name,$icing,$weapon)
            puts "Your donut's info is: Their name is #{$name}, and they have #{$icing} icing. They're armed with their #{$weapon} and have health of 10. It is time to start."
        else
            puts "Insert your donuts data again."
            beginning()
        end
    end
end


def encounter(player, foe)
    if foe.foe_type == "pistachio"
        puts "The final enemy has appeared! It is a #{foe.foe_type} named #{foe.foe_name}. It will do #{foe.foe_damage} damage. It has #{foe.foe_health} health. What will you do, brave warrior?"
    else
        puts "An enemy has appeared! It is a #{foe.foe_type} named #{foe.foe_name}. It will do #{foe.foe_damage} damage. It has #{foe.foe_health} health. What will you do?"
    end
    while foe.foe_health > 0
        puts "Dodge, Block, or Attack?"
        action = gets.chomp.downcase
        puts
         # dodge, block, or attack
        if action == "attack"
            roll = 1 + rand(10)
            if foe.foe_accuracy >= roll
                puts "#{foe.foe_name} attacked!"
                puts "#{player.name} took #{foe.foe_damage} damage.".color(player.icing)
                player.health = player.health - foe.foe_damage
                if 0 >= player.health 
                    player.health = 0
                end
                # dilly's health after the encounter
                puts "#{player.name} has #{player.health} health remaining.".color(player.icing)
            else
                puts "#{foe.foe_name}'s attack missed!"
                puts "#{player.name} took no damage!".color(player.icing)
            end
            if player.health > 0
                puts "#{player.name} dealt #{player.attack_damage} damage to the #{foe.foe_type}!".color(player.icing)
                foe.foe_health = foe.foe_health - player.attack_damage
                if 0 >= foe.foe_health 
                    foe.foe_health = 0
                end
                puts "#{foe.foe_name} has #{foe.foe_health} health remaining."
            end
            puts
        end
        if action == "block"
            puts "#{foe.foe_name} attacked!"
            puts "#{player.name} took half damage!".color(player.icing)
            player.health = player.health - (foe.foe_damage/2)
            player.health = player.health.round
            if 0 >= player.health 
                player.health = 0
            end
            # dilly's health after the encounter
            puts "#{player.name} has #{player.health} health remaining.".color(player.icing)
            puts
        end
        if action == "dodge"
            roll = 1 + rand(10)
            if player.evasion >= roll
                puts "#{player.name} dodged the attack!".color(player.icing)
                puts "#{player.name} took no damage!".color(player.icing)
                puts
            else
                puts "#{player.name} couldn't dodge the attack!".color(player.icing)
                puts "#{player.name} took #{foe.foe_damage} damage!".color(player.icing)
                player.health = player.health - foe.foe_damage
                if 0 >= player.health 
                    player.health = 0
                end
                # dilly's health after the encounter
                puts "#{player.name} has #{player.health} health remaining.".color(player.icing)
                puts
            end
        end
    end
    if 0 >= player.health 
        puts "Oh no! #{player.name} has no health left!"
        puts "#{player.name} fainted"
        abort("GAME OVER")
    end
    if 0 >= foe.foe_health 
        puts "#{foe.foe_name} the #{foe.foe_type} was defeated!"
        if foe.foe_type == "pistachio"
            puts "#{player.name} is victorious! You have triumphed over all the enemies! Congratulations!"
            puts "Collect your prize!"
            prizechoice = HighLine.new
            # HighLine::Menu.index_color   = :rgb_99ccaa # set default index color
            
            prizechoice.choose do |menu|
                menu.index        = :letter
                menu.index_suffix = ") "
            # menu.index_color = :pink          # override default color of index
                                                # you can also use constants like :blue
                menu.choice(:diamond) do $prize = "diamond" end
                menu.choice(:tophat) do $prize = "tophat" end
                menu.choice(:pistachio) do $prize = "pistachio" end
                menu.choice(:music) do $prize = "music" end
            end
            if $prize == "diamond"
                puts "
                      *********
                     ***********
                    *************
                      *********
                        *****
                          *"
            elsif $prize == "tophat"
                puts "
                      ********
                      ********
                      ********
                      ********
                    ************"
            elsif $prize == "pistachio"
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
            
            elsif $prize == "music"
                puts "All time faves selected from my thirty something or so playlists
                    Now - Joywave
                    Cherry - Chromatics
                    Hellboy - Seth Sentry
                    Cigarettes & Loneliness - Chet Faker
                    Shoulders & Arms - Tokyo Police Club"
            end
        else
            puts "#{player.name} gained #{foe.foe_damage} health for defeating the #{foe.foe_type}.".color(player.icing)
            player.health = player.health + foe.foe_damage
            puts "#{player.name} has #{player.health} health remaining.".color(player.icing)
            puts
            puts "Continue?"
            cont = gets.chomp.downcase
            if cont == "yes"
                puts "Good. Let's keep going."
            else
                abort("Bye. Have a good one.")
            end
        end
    end
end


puts beginning()

puts encounter($player, dinosaur)
puts encounter($player, human)
puts encounter($player, rock)
puts encounter($player, pistachio)

