# our happy little donut is going on an advneture

require 'highline'
require 'ruby_mud'

class Game
    def initialize
        @player = Donut.new($name,$icing,$weapon)
        @dinosaur = Foes.new("dinosaur","Kitty",1,5,5)
    end
    
    def beginning()
        puts "Dear donut owner, your little pretty mascot is about to suffer a dangerous encounter with one enemy. We are sad to announce that your donut may lose their life. If you refuse to let your mascot fight, leave this game immediately. Would you like to stay and be a brave warrior?"
            answer = gets.chomp
        if answer != "yes"
            puts "Bye. Have a good one."
        else
            puts "First let's ask some questions to the donut owner: What is the name of your donut?"
            $name = gets.chomp.capitalize
            puts "What is your icing?"
            $icing = gets.chomp.downcase
            
            weaponchoice = HighLine.new
            # HighLine::Menu.index_color   = :rgb_99ccaa # set default index color
            
            weaponchoice.choose do |menu|
            # menu.index_color = :pink              # override default color of index
                                                   # you can also use constants like :blue
                menu.prompt = "What is your donuts weapon?"
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
                puts "Your donut's info is: Their name is #{$name}, and they have #{$icing} icing. They're armed with their #{$weapon} and have health of 10. It is time to start."
            else
                puts "Insert your donuts data again."
                beginning()
            end
        end
    end
    def encounter(foe)
        puts "An enemy has appeared! It is a #{foe.foe_type} named #{foe.foe_name}. It will do #{foe.foe_damage} damage. It has #{foe.foe_health} health. What will you do?"
        while foe.foe_health > 0
            puts "Dodge, Block, or Attack?"
            action = gets.chomp.downcase
             # dodge, block, or attack
            if action == "attack"
                puts "#{$player.name} dealt #{$player.attack_damage} damage to the #{foe.foe_type}!"
                roll = 1 + rand(10)
                if foe.foe_accuracy >= roll
                    puts "#{foe.foe_name} attacked!"
                    puts "#{$player.name} took #{foe_info.damage} damage."
                    $player.health = $player.health - foe.foe_damage
                    # dilly's health after the encounter
                    puts "#{$player.name} has #{$player.health} health remaining."
                elsif
                    puts "#{foe.foe_name}'s attack missed!"
                    puts "#{$player.name} took no damage!"
                end
            end
            if action == "block"
                puts "#{$player.name} took half damage!"
                $player.health = $player.health - foe.foe_damage/2.round
                # dilly's health after the encounter
                puts "#{$player.name} has #{$player.health} health remaining."
            end
            if action == "dodge"
                roll = 1 + rand(10)
                if $player.evasion >= roll
                    puts "#{$player.name} dodged the attack!"
                    puts "#{$player.name} took no damage!"
                elsif
                    puts "#{$player.name} couldn't dodge the attack!"
                    $player.health = $player.health - foe.foe_damage
                    puts "#{$player.name} took #{foe.foe_damage} damage!"
                    # dilly's health after the encounter
                    puts "#{$player.name} has #{$player.health} health remaining."
                end
            end
        end
        if 0 >= foe.foe_health 
            puts "#{foe.foe_name} the #{foe.foe_type} was defeated!"
        end
    end
end


def Donut
    attr_reader :name, :icing
    attr_accessor :self_defense, :health
    def initialize(donut_name, donut_icing, donut_weapon)
        @name = donut_name
        @icing = donut_icing
        @self_defense = donut_weapon
        @health = 10
        @attack_damage = 0
        @evasion = 0
    end
    def stats
        puts "Your donut's info is: Its name is #{@name} and it has #{@icing} icing. It is arm with #{@self_defense} and has health of #{@health}."
    end
    def info
       puts "Name: #{@name}"
       puts "Icing: #{@icing}"
       puts "Weapon: #{@self_defense}"
       puts "Health: #{@health}"
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

def Foes
    attr_reader :foe_type, :foe_name, :foe_damage, :foe_accuracy
    attr_accessor :foe_health
    def initialize(foe_type,foe_name,foe_damage,foe_health,foe_accuracy)
        @foe_type = foe_type
        @foe_name = foe_name
        @foe_damage = foe_damage
        @foe_health = foe_health
        @accuracy = foe_accuracy
    end
    def stats
        puts "Type: #{@foe_type}"
        puts "Name: #{@foe_name}"
        puts "Damage: #{@foe_damage}"
        puts "Health: #{@foe_health}"
    end
end








Game.new