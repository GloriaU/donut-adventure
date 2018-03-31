# our happy little donut is going on an advneture

require 'highline'
require 'ruby_mud'
require 'colorize'

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

dinosaur = Foes.new("dinosaur","Kitty",1,5,5)
human = Foes.new("hungry human","Taylor Want",3,4,8)
rock = Foes.new("rock","Rocky",4,8,3)
pistachio = Foes.new("pistachio","Gloria",7,3,6)

class Donut
    attr_reader :name, :icing, :textcolor
    attr_accessor :self_defense, :health, :attack_damage, :evasion
    def initialize(name,icing,self_defense)
        @name = name
        @icing = icing
        @self_defense = self_defense
        @health = 10
        if @icing == "glaze"
            @textcolor = ":background => :white"
        elsif @icing == "chocolate"
            @textcolor = ":background => :yellow"
        elsif @icing == "stawberry"
            @textcolor = ":background => :light_red"
        elsif @icing == "lemon"
            @textcolor = ":background => :light_yellow"
        end
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
    puts "Dear donut owner, your little pretty mascot is about to suffer a dangerous encounter with one enemy. We are sad to announce that your donut may lose their life. If you refuse to let your mascot fight, leave this game immediately. Would you like to stay and be a brave warrior?"
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
            menu.prompt = "What is your donut's icing?"
            menu.choice(:glaze).colorize(:background => :white) do $icing = "glaze" end
            menu.choice(:chocolate).colorize(:background => :yellow) do $icing = "chocolate" end
            menu.choice(:strawberry).colorize(:background => :light_red) do $icing = "stawberry" end
            menu.choice(:lemon).colorize(:background => :light_yellow) do $icing = "lemon" end
        end
        puts
        
        weaponchoice = HighLine.new
        # HighLine::Menu.index_color   = :rgb_99ccaa # set default index color
        
        weaponchoice.choose do |menu|
            menu.index        = :letter
            menu.index_suffix = ") "
        # menu.index_color = :pink              # override default color of index
                                               # you can also use constants like :blue
            menu.prompt = "What is your donut's weapon?"
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
    puts "An enemy has appeared! It is a #{foe.foe_type} named #{foe.foe_name}. It will do #{foe.foe_damage} damage. It has #{foe.foe_health} health. What will you do?"
    while foe.foe_health > 0
        puts "Dodge, Block, or Attack?"
        action = gets.chomp.downcase
        puts
         # dodge, block, or attack
        if action == "attack"
            roll = 1 + rand(10)
            if foe.foe_accuracy >= roll
                puts "#{foe.foe_name} attacked!"
                puts "#{player.name} took #{foe.foe_damage} damage.".colorize(player.textcolor)
                player.health = player.health - foe.foe_damage
                # dilly's health after the encounter
                puts "#{player.name} has #{player.health} health remaining.".colorize(player.textcolor)
            elsif
                puts "#{foe.foe_name}'s attack missed!"
                puts "#{player.name} took no damage!".colorize(player.textcolor)
            end
            puts "#{player.name} dealt #{player.attack_damage} damage to the #{foe.foe_type}!".colorize(player.textcolor)
            foe.foe_health = foe.foe_health - player.attack_damage
            puts "#{foe.foe_name} has #{foe.foe_health} health remaining."
            puts
        end
        if action == "block"
            puts "#{foe.foe_name} attacked!"
            puts "#{player.name} took half damage!".colorize(player.textcolor)
            player.health = player.health - (foe.foe_damage/2)
            player.health = player.health.round
            # dilly's health after the encounter
            puts "#{player.name} has #{player.health} health remaining.".colorize(player.textcolor)
            puts
        end
        if action == "dodge"
            roll = 1 + rand(10)
            if player.evasion >= roll
                puts "#{player.name} dodged the attack!".colorize(player.textcolor)
                puts "#{player.name} took no damage!".colorize(player.textcolor)
            elsif
                puts "#{player.name} couldn't dodge the attack!".colorize(player.textcolor)
                puts "#{player.name} took #{foe.foe_damage} damage!".colorize(player.textcolor)
                player.health = player.health - foe.foe_damage
                # dilly's health after the encounter
                puts "#{player.name} has #{player.health} health remaining.".colorize(player.textcolor)
                puts
            end
        end
    end
    if 0 >= foe.foe_health 
        puts "#{foe.foe_name} the #{foe.foe_type} was defeated!"
        puts "Continue?"
        cont = gets.chomp.downcase
        if cont == "yes"
            puts "Good. Let's keep going."
        else
            abort("Bye. Have a good one.")
        end
    end
end


puts beginning()

puts encounter($player, dinosaur)

